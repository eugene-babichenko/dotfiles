function portainer
	if docker ps | grep portainer
		docker stop portainer
	end
	if docker ps -a | grep portainer
		docker rm portainer
	end
	docker run -d -p 9000:9000 \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v portainer_data:/data \
		--name portainer \
		portainer/portainer
end
