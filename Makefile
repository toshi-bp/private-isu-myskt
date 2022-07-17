include .env

build:
	cd webapp/golang/ && go build -o app

push:
	ssh isucon@${PROD_SERVER} "sudo systemctl stop isu-go"
	scp webapp/golang/app isucon@${PROD_SERVER}:/home/isucon/private_isu/webapp/golang/app
	ssh isucon@${PROD_SERVER} "sudo systemctl start isu-go"

bench:
	ssh ubuntu@${BENCH_SERVER} "sudo -u isucon /home/isucon/private_isu.git/benchmarker/bin/benchmarker -u /home/isucon/private_isu.git/benchmarker/userdata -t http://${PROD_SERVER}"
