# Welcome to Cloud Functions for Firebase for Python!
# To get started, simply uncomment the below code or create your own.
# Deploy with `firebase deploy`

import datetime
from firebase_functions import https_fn,options
from firebase_admin import initialize_app , firestore , messaging

options.set_global_options(max_instances=10)
initialize_app()


@https_fn.on_call()
def responsForAddwork(req: https_fn.Request) -> https_fn.Response:
# data has 

# ok? 
# senderId
# workerId
# originalId
# date
# amountSpent
# quantity
# typeName
# token
# message
    

    # send data just in order to validate the token



    data = req.data
    if(data['ok']):
     db = firestore.client()
     db.collection("users/"+data["senderId"]+"/workers/"+ data["workerId"] +"/work").document(data["date"]).create({
         'amountSpent': int(data["amountSpent"]),
         'id': int( data['originalId']),
         'timeStamp': datetime.datetime.__sub__(datetime.datetime.fromisoformat(data["date"]),datetime.timedelta(0,0,0,0,0,3,0)),
         'quantity':int( data["quantity"]),
         'typeName': data["typeName"],
     })

    message = messaging.Message(
        token=data['token'],
        android=messaging.AndroidConfig(priority='high'),
        data=data['data'],
        # notification=messaging.Notification(title=data['message'],  body=data['messageBody'],                                
        # )
    )
    try:
        messaging.send(message)
    except Exception as error:
       print(error)


@https_fn.on_call()
def sendPaidAllRequest(request: https_fn.CallableRequest) -> https_fn.Response:
    data = request.data
    message = messaging.Message(
        token=data['token'],
        data=data['data'],
        android=messaging.AndroidConfig(priority='high'),
        # notification=messaging.Notification(title="تصفية الحساب بواسطة "+data['shopName'],
        # body=data['messageBody'],
        # )
    )
    try:   
        messaging.send(message)
    except:
       message2 = messaging.Message(
        token=data['shopToken'],
        data={'workerId':data['workerId']},
        android=messaging.AndroidConfig(priority='high'),
       )
       messaging.send(message2)
       

@https_fn.on_call()
def sendTypeMessage(request: https_fn.CallableRequest) -> https_fn.Response:
    data = request.data
    message = messaging.Message(
        topic=data['shopId']+'types',
        data=data['data'],
        android=messaging.AndroidConfig(priority='high'),
        # notification=messaging.Notification(title=data['messageTitle'],
        # body=data['messageBody'],
        # )
    )
    try:
        messaging.send(message)
    except Exception as error:
       print(error)
       
