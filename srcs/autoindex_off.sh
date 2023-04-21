#!/bin/bash

replace "autoindex on" "autoindex off" -- /etc/nginx/sites-available/default
service nginx restart
bash
