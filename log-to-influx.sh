#curl -XPOST -u admin:admin123 "192.168.0.95:8086/write?db=telegraf" --data-binary 'meal,food=egg calories=70,amount=4,protein=6,carbohydrate=0,fat=5'
curl -XPOST -u admin:admin123 "192.168.0.95:8086/write?db=telegraf" --data-binary 'weight value='$1

