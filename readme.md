# Docker를 이용한 개발환경 설정(맥 기준)

## docker, docker-compose 설치
- https://hub.docker.com/
- https://docs.docker.com/compose/install/
***

## 기본 수정사항
##### docker-compose.yml 파일을 열고 아래 부분의 경로를 수정
* /Users/IdeaProjects/ < 이 부분을 본인의 경로에 맞게 수정
<pre><code>volumes:
  - "/Users/IdeaProjects/home:/var/www/home"
</code></pre>

### host 추가<a id="host-add"></a>
#### hosts 파일 열기 (암호 입력 필요)
* sudo vim /etc/hosts
#### hosts 파일 수정(아래 내용 추가)
* 127.0.0.1     local.kr
#### 저장 후 아래 명령어 실행
* dscacheutil -flushcache
***

## 실행
#### 설정 변경 시 적용
- docker-compose build
#### 실행
- docker-compose up -d
#### 중지
- docker-compose stop
***

## 사이트 추가
### Dockerfile 파일을 열고 아래 부분 추가(api를 추가할 경우)
* RUN mkdir -p /var/www/api
### vhost.conf 파일을 열고 Virtualhost 내용 추가(경로 등 적절히 수정 필요)
<pre><code>&lt;VirtualHost *:80&gt;
   DocumentRoot "/var/www/api/"
   ServerName api-local.kr
   ErrorLog "logs/api_err_log"
   CustomLog "logs/api_con_log" common
   &lt;Directory /var/www/api &gt;
      Require all granted
      AllowOverride All
    &lt;/Directory&gt;
&lt;/VirtualHost&gt;</code></pre>
#### [host 추가](#host-add) 실행
##### 아래 명령 실행
- docker-compose stop
- docker-compose build
- docker-compose up
***
