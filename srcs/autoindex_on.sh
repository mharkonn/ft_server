#!/bin/bash

replace "autoindex off" "autoindex on" -- /etc/nginx/sites-available/default
service nginx restart
bash
