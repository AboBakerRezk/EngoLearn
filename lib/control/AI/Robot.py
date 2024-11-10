import numpy as np
import string
import pandas as pd
from fastapi import FastAPI, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.tree import DecisionTreeClassifier
from sklearn.feature_extraction.text import TfidfTransformer
from sklearn.pipeline import Pipeline
from sqlalchemy import create_engine, Column, Integer, String, DateTime
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, Session
import datetime
import uvicorn

# إعداد التطبيق
app = FastAPI()

# إعداد CORS
origins = ["http://localhost", "http://127.0.0.1", "http://192.168.1.4"]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# إعداد قاعدة البيانات
DATABASE_URL = "sqlite:///chatbot_logs.db"
Base = declarative_base()
engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

class ChatLog(Base):
    __tablename__ = 'chat_logs'
    id = Column(Integer, primary_key=True, index=True)
    user_message = Column(String, nullable=False)
    bot_response = Column(String, nullable=False)
    timestamp = Column(DateTime, default=datetime.datetime.utcnow)

Base.metadata.create_all(bind=engine)

# تحميل بيانات المحادثات
df = pd.read_csv('../input/simple-dialogs-for-chatbot/dialogs.txt', sep='\t')
df.columns = ['Questions', 'Answers']

# إضافة بعض الأسئلة الشائعة
common_questions = [
    {'Questions': 'Hi', 'Answers': 'hello'},
    {'Questions': 'Hello', 'Answers': 'hi'},
    {'Questions': 'how are you', 'Answers': "i'm fine. how about yourself?"},
    {'Questions': 'how are you doing', 'Answers': "i'm fine. how about yourself?"}
]
for question in common_questions:
    df = df.append(question, ignore_index=True)

# إعداد النموذج
def cleaner(x):
    return [a for a in (''.join([a for a in x if a not in string.punctuation])).lower().split()]

pipe = Pipeline([
    ('bow', CountVectorizer(analyzer=cleaner)),
    ('tfidf', TfidfTransformer()),
    ('classifier', DecisionTreeClassifier())
])

pipe.fit(df['Questions'], df['Answers'])

class ChatRequest(BaseModel):
    message: str

class ChatResponse(BaseModel):
    response: str

@app.post("/chat", response_model=ChatResponse)
async def chat_with_bot(request: ChatRequest, db: Session = Depends(get_db)):
    try:
        user_message = request.message
        bot_response = pipe.predict([user_message])[0]  # استخدام النموذج للتنبؤ
        chat_log = ChatLog(user_message=user_message, bot_response=bot_response)
        db.add(chat_log)
        db.commit()
        return ChatResponse(response=bot_response)
    except Exception as e:
        raise HTTPException(status_code=500, detail="Internal Server Error")

# تشغيل الخادم
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)


