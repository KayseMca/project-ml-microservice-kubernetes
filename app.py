from importlib.resources import path

# from cryptography import sys
from flask import Flask, request, jsonify
from flask.logging import create_logger
import logging
import json
import pandas as pd
from sklearn.externals import joblib
from sklearn.preprocessing import StandardScaler
import os, sys

path = os.path.dirname(os.path.realpath(__file__))
app = Flask(__name__)
LOG = create_logger(app)
LOG.setLevel(logging.INFO)

def scale(payload):
    """Scales Payload"""
    
    LOG.info(f"Scaling Payload: \n{payload}")
    scaler = StandardScaler().fit(payload.astype(float))
    scaled_adhoc_predict = scaler.transform(payload.astype(float))
    return scaled_adhoc_predict

@app.route("/")
def home():
    html = f"<h3>Sklearn Prediction Home</h3>"
    return html.format(format)

@app.route("/predict", methods=['POST'])
def predict():
    print("prediciting")
    sys.stdout.flush()
    """Performs an sklearn prediction
        
        input looks like:
        {
        "CHAS":{
        "0":0
        },
        "RM":{
        "0":6.575
        },
        "TAX":{
        "0":296.0
        },
        "PTRATIO":{
        "0":15.3
        },
        "B":{
        "0":396.9
        },
        "LSTAT":{
        "0":4.98
        }
        
        result looks like:
        { "prediction": [ <val> ] }
        
        """
    
    # Logging the input payload
    json_payload = request.json
    # LOG.info(f"JSON payload: \n{json_payload}")
    inference_payload = pd.DataFrame(json_payload)
    LOG.info(f"Inference payload DataFrame: \n{inference_payload}")
    # scale the input
    scaled_payload = scale(inference_payload)
    # get an output prediction from the pretrained model, clf
    prediction = list(clf.predict(scaled_payload))
    # TO DO:  Log the output prediction value
    LOG.info(f"prediction payload: \n{prediction}")
    sys.stdout.flush()
    # copy the result to file
    join_path = os.path.join(path, "output_txt_files", "docker_out.txt")
    try:
        with open(join_path,'w') as f:
            f.write(str(json_payload))
            print("######interface")
            # f.write(json.dumps(inference_payload.to_dict()))
            # print("######scaled")
            # f.write(json.dumps(scaled_payload))
            # print("######prediciton")
            # f.write(json.dumps(prediction))
    except:
        print("File not found or path")
    return jsonify({'prediction': prediction})

if __name__ == "__main__":
    # load pretrained model as clf
    clf = joblib.load("./model_data/boston_housing_prediction.joblib")
    app.run(host='0.0.0.0', port=80, debug=True) # specify port=80
