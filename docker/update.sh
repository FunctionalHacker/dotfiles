#!/bin/zsh
for dir in */; do
	cd $dir
	docker-compose pull && docker-compose down && docker-compose up -d
	cd ..
done
