NOW=$$(date +'%Y%m%d_%H%M%S')

image: # run to build docker image
	@docker build -t zephinzer/blog:latest .
publish: image # run to publish to docker hub
	@docker tag zephinzer/blog:latest zephinzer/blog:$(NOW)
dev: image # run to dev
	@docker run \
		--publish 4000:4000 \
		--publish 40000:40000 \
		--volume "$$(pwd)/src:/blog/src" \
		zephinzer/blog:latest \
		serve \
			--host 0.0.0.0 \
			--livereload \
			--livereload-port 40000 \
			--port 4000
init: image # run once only
	-@docker run \
		-u $$(id -u) \
		-v "$$(pwd):/blog" \
		zephinzer/blog:latest new src