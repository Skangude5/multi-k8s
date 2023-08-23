docker build -t skangude5/multi-client:latest -t skangude5/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t skangude5/multi-server:latest -t skangude5/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t skangude5/multi-worker:latest -t skangude5/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push skangude5/multi-client:latest
docker push skangude5/multi-client:$SHA
docker push skangude5/multi-server:latest
docker push skangude5/multi-server:$SHA
docker push skangude5/multi-worker:latest
docker push skangude5/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=skangude5/multi-server:$SHA
kubectl set image deployments/client-deployment client=skangude5/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=skangude5/multi-worker:$SHA