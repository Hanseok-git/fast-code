FROM public.ecr.aws/nginx/nginx:stable-perl
WORKDIR /usr/share/nginx/html/
COPY ./index.html ./
