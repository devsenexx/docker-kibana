server {
    listen       80;
    server_name  _;
    location /kopf {
        alias         /kopf/_site;
    }
    
    location /kibana {
	rewrite /kibana/(.*)$ /$1 break;
        proxy_set_header        Host $host;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Proto $scheme;
        proxy_pass          http://localhost:5601;
        proxy_read_timeout  90;        
    }

    location / {
        proxy_set_header        Host $host;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Proto $scheme;
        proxy_pass          http://{{ ELASTICSEARCH_HOST }}:{{ ELASTICSEARCH_PORT }};
        proxy_read_timeout  90;
        #proxy_set_header Authorization "Basic ZWxhc3RpYzpjaGFuZ2VtZQ==";
        client_max_body_size 0 ;
        proxy_buffering on;
        proxy_buffer_size 1k;
        proxy_buffers 24 4k;
        proxy_busy_buffers_size 8k;
        proxy_max_temp_file_size 2048m;
        proxy_temp_file_write_size 32k;

	}
}
