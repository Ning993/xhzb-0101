# 基础镜像
FROM eclipse-temurin:17-jdk
# 设定时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 环境变量（构建时通过 --build-arg 传入，切勿硬编码真实密钥）
ARG OSS_ACCESS_KEY_ID
ARG OSS_ACCESS_KEY_SECRET
ARG OPENAI_API_KEY
ENV OSS_ACCESS_KEY_ID=${OSS_ACCESS_KEY_ID}
ENV OSS_ACCESS_KEY_SECRET=${OSS_ACCESS_KEY_SECRET}
ENV OPENAI_API_KEY=${OPENAI_API_KEY}


# 拷贝jar包
COPY xhzb-admin.jar /app.jar

# 暴露端口
EXPOSE 9000

# 入口
ENTRYPOINT ["java", "-jar", "/app.jar"]