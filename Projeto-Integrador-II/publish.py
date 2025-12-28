import json
import time
import paho.mqtt.client as mqtt

#MQTT_BROKER = "broker.hivemq.com"
MQTT_BROKER = "feira-de-jogos.dev.br"
TOPIC_COMMAND = "vending-machine/0/command"

# Leitura do arquivo JSON
with open("product.json", "r") as f:
    payload = json.load(f)   # payload = {"product": 1}

# Publish MQTT
client = mqtt.Client()
client.connect(MQTT_BROKER, 1883, 60)

client.publish(TOPIC_COMMAND, json.dumps(payload))
 
client.loop(timeout=1.0)

client.disconnect()

print("Command sent:", payload)
