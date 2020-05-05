Step to launch postgresql on AWS

Installing Docker

The next step is to install Docker on your EC2 Instance. Open a terminal, cd over to the folder where you saved your Key Pair, and run the following commands:

> cd /User/ajitdubey/Downloads
> chmod 400 docker-psql.pem
> ssh -i docker-psql.pem ec2-user@<EC2-INSTANCE-PUBLIC-IP-ADDRESS>
If you did everything correctly, you should see something like this:

       __|  __|_  )
       _|  (     /   Amazon Linux AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-ami/2015.09-release-notes/
[ec2-user]$
You are now in control of a fully working Linux server running in the AWS cloud. Let’s install Docker on it.

[ec2-user]$ sudo yum update -y
[ec2-user]$ sudo yum install -y docker
[ec2-user]$ sudo service docker start
Next, add the ec2-user to the docker group so you can execute Docker commands without using sudo. Note that you’ll have to log out and log back in for the settings to take effect:

[ec2-user]$ sudo usermod -a -G docker ec2-user
[ec2-user]$ exit

> ssh -i docker-psql.pem ec2-user@<EC2-INSTANCE-PUBLIC-IP-ADDRESS>

[ec2-user]$ docker info
If you did everything correctly, the last command, docker info, will return lots of information about your Docker install without any errors.

Finally, you can run the training/webapp image:

[ec2-user]$ docker run --name pg_test -it -d -p 5432:5432 dubeyajit/eg_postgresql:v01

The -p 80:5000 flag in the command above tells Docker to link port 5000 on the Docker container to port 80 on the EC Instance. You can test that the Docker image is running as follows:


[ec2-user]$ docker run --name gnuhealthOS -it -d -p 80:8000 dubeyajit/gnuhealth:v01

