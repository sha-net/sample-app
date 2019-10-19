from flask import Flask, request, jsonify
import json
import redis
app = Flask(import_name=__name__)
r = redis.StrictRedis(host='127.0.0.1', port=6379)

@app.route('/postjson', methods = ['POST'])
def postjson():
    print (request.is_json)
    content = request.get_json()
    print(content)   
    r.execute_command('JSON.SET', 'doc', '.', json.dumps(content))
    reply = json.loads(r.execute_command('JSON.GET', 'doc'))
    print(reply)
    return jsonify(status='insert')

@app.route('/getjson', methods=['GET'])
def getjson():
    #r = redis.StrictRedis(host='127.0.0.1', port=6379)
    reply = json.loads(r.execute_command('JSON.GET', 'doc'))
    print(reply)
    return reply

@app.route('/deljson', methods=['DELETE'])
def deljson():
    #r = redis.StrictRedis(host='127.0.0.1', port=6379)
    reply = r.execute_command('JSON.DEL', 'doc')
    #reply = json.loads(r.execute_command('JSON.DEL', 'doc'))
    print(reply)
    return jsonify(status='deleted')

if __name__ == "__main__":
 app.debug = True
 app.run()


#docker run -d -p 6379:6379 --name redis-redisjson redislabs/rejson:latest
#docker exec -it redis-redisjson bash
#curl -X POST localhost:5000/postjson -d@demofile2.json -H "Content-Type: application/json"
#curl -X GET localhost:5000/getjson
#curl -X DELETE localhost:5000/deljson