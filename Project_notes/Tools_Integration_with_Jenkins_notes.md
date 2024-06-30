# Integrating Gmail Notifications with Jenkins on Windows 10 📬🔔

## Prerequisites 🛠️

Before you start, make sure to enable SMTP access in your Gmail settings to allow Jenkins to send emails using your Gmail account. Here's how:

1. Navigate to **Manage Google Account** > **Security**.
2. Click on **2-Step Verification**.
3. Scroll down to **App Password** and click on it.
4. Follow the instructions displayed to create an App password. Remember to save this password as it will be displayed only once. For example, your App password might look something like this: `inbz lqez dwfx dhxh`.

## Plugin 🧩

The **Email Extension Plugin** is included by default in recent versions of Jenkins, which simplifies the process of setting up email notifications for your builds.

## Credentials Setup 🔑

To set up the credentials in Jenkins:

1. Go to **Jenkins Dashboard** > **Manage Jenkins** > **Manage Credentials**.
2. Click on **(global)** under **Stores scoped to Jenkins**.
3. Click on **Add Credentials** on the left side.
4. In the **Kind** dropdown, select **Username with password**.
5. In the **Username** field, enter your Gmail username. In the **Password** field, enter your App password (not your Gmail password).
6. In the **ID** field, enter a unique ID for this credential (e.g., `gmail`).
7. Click **OK** to save the credential.



To configure the email notification:

1. Go to **Manage Jenkins** > **Configure System**.
2. Find the **Email Notification** tab and fill in the details:
   - **SMTP server name**: smtp.gmail.com
   - **Default user e-mail suffix**: @gmail.com
   - **User name**: user_email_id@gmail.com
   - **Password**: 123456
   - **Use SSL**: Checked
   - **SMTP Port**: 465

You can verify the email notification functionality by ticking the checkbox next to the **Test configuration by sending Test e-mail recipient** option. Enter a valid email ID and click the **Test configuration** button to check whether the email ID is valid or not.


# Extended E-mail Notification Setup 📧🔔

To configure the extended email notification:

1. Go to **Manage Jenkins** > **Configure System**.
2. Find the **Extended E-mail Notification** tab and fill in the details:
   - **SMTP server name**: smtp.gmail.com
   - **SMTP Port**: 465
   - In the **Advanced** tab, fill in the following details:
     - In the **Credentials** tab, upload/add the Gmail credentials that you created in the credential setup.
     - **Use SSL**: Checked
     - **Default user e-mail suffix**: @gmail.com

## Jenkinsfile Example 🚀

```groovy
pipeline {
    agent any
    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
    }
    post {
        always {
            script {
                env.BUILD_TIMESTAMP = new Date(currentBuild.startTimeInMillis).format('MMMM dd, yyy | hh:mm:ss aaa | z')
            }
            emailext (
                subject: "${currentBuild.currentResult} Build Report as of ${BUILD_TIMESTAMP} — ${env.JOB_NAME}",
                body: """The Build report for ${env.JOB_NAME} executed via Jenkins has finished its latest run.

- Job Name: ${env.JOB_NAME}
- Job Status: ${currentBuild.currentResult}
- Job Number: ${env.BUILD_NUMBER}
- Job URL: ${env.BUILD_URL}

Please refer to the build information above for additional details.

This email is generated automatically by the system.
Thanks""",
                recipientProviders: [[$class: 'DevelopersRecipientProvider']],
                to: 'username@gmail.com',
                attachLog: true
            )
        }
    }
}
```


---

# GitHub Webhook Integration with Jenkins 🚀

## Prerequisites 🛠️

Before you start, make sure you have the following:

1. An existing GitHub account and a project repository.
2. Jenkins installed and running on your system.

> Note: The Git plugins come pre-installed with Jenkins, simplifying the setup process.

## Configuration Steps 🔧

Follow these steps to configure the GitHub webhook with Jenkins:

1. **Copy the Jenkins URL**:
   - For example, `http://localhost:9082`. Note that in this example, a custom port is used instead of the default Jenkins port 8080.

2. **Navigate to your project repository on GitHub**:
   - Click on **Settings** at the repository level.

3. **Go to Webhooks & services**:
   - Click on **Add webhook**.

4. **Fill in the required fields**:
   - **Payload URL**: Enter your Jenkins URL followed by `/github-webhook`. For example, `<JenkinsURL>/github-webhook`.
   - **Content type**: Select `application/json`.
   - Leave the remaining fields as they are unless there are specific requirements for your project.

## Making Localhost Public Using CloudFlare ☁️

### Prerequisites:

Before you start, ensure that you have the following:

1. The CloudFlare application downloaded on your machine.
2. Jenkins installed and running on your system.

### How to Use:

1. **Download `cloudflared` onto your machine**:
   - You can find the appropriate package for your operating system on the [downloads page](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/downloads/).
   - For Windows, use this [direct link to download the executable](https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-windows-amd64.exe).

2. **Rename the downloaded package**:
   - Name it `cloudflared.exe`.

3. **Open PowerShell**:
   - Change the directory to your Downloads folder.
   - Run the command: `.\cloudflared.exe --version`.
   - This should output the version of `cloudflared`, for example: `cloudflared version 2024.3.0 (built 2024-03-20-1009 UTC)`.

> Note: The executable could be named `cloudflared-windows-amd64.exe` or `cloudflared-windows-386.exe` if you haven't renamed it.

🌐 Now your localhost is accessible from the public internet using CloudFlare!

---

# Making Jenkins URL Public 🌐

To make your Jenkins URL public, follow these steps:

1. **Navigate to the CloudFlare directory**:
   - Run the command: `.\cloudflared.exe --url localhost:9081`.
   - This will generate a public URL, for example: [https://sa-luxury-impacts-chevy.trycloudflare.com](https://sa-luxury-impacts-chevy.trycloudflare.com).

## Why Use Cloudflare? ☁️

Webhooks generally do not work with `localhost:<Port-Num>` because it only has local internet access. To use webhooks, you need to convert the localhost to a public host. After researching several applications, Cloudflare was found to be user-friendly and easy to set up.

> **Note**:
> - You did not specify any valid additional argument to the Cloudflare tunnel command.
> - If you are trying to run a Quick Tunnel, you need to explicitly pass the `--URL` flag.
>   - For example: `cloudflared tunnel --URL localhost:8080/`.
> - Please note that Quick Tunnels are meant to be ephemeral and should only be used for testing purposes.
> - For production usage, we recommend creating Named Tunnels. [Learn more](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/tunnel-guide/)
---

# Maven and Java Configuration Process 🛠️

## Prerequisites 🚀

Before you start, make sure you have the following installed:

1. **Maven**: The installation process depends on your operating system. You can follow the instructions provided in the official documentation or online blogs:
   - Maven Installation Guide for Windows: [Install Maven on Windows](https://phoenixnap.com/kb/install-maven-windows)
   - Maven Installation Guide for other platforms: [Maven Downloads](https://maven.apache.org/download.cgi)

2. **Java**: You can download the latest version of Java from the following sources:
   - [Adoptium Temurin Releases](https://adoptium.net/temurin/releases/)
   - [Install Java on Windows](https://phoenixnap.com/kb/install-java-windows)

> **Note**: The Maven and Java plugins are pre-installed with Jenkins, which simplifies the setup process.

## Configuration Steps in Jenkins Settings 🔧

To configure Maven and Java in Jenkins, follow these steps:

1. Go to **Manage Jenkins** > **Global Tool Configuration**.

### Maven Configuration 📦

Navigate to the **Maven** section:
1. Click on **Maven installations...** > **Add Maven**.
2. Fill in the required fields:
   - **Name**: Enter a name for this Maven installation (e.g., Maven).
   - **MAVEN_HOME**: Enter the path where Maven is installed on your system (e.g., `C:\Program Files\Maven-3.9.6\apache-maven-3.9.6`).

### Java Configuration ☕

Navigate to the **JDK** section:
1. Click on **JDK installations...** > **Add JDK**.
2. Fill in the required fields:
   - **Name**: Enter a name for this JDK installation (e.g., Java22).
   - **JAVA_HOME**: Enter the path where Java is installed on your system (e.g., `C:\java_home`).

To verify the home locations of Maven and Java, open your system’s command line and run:
```bash
mvn -v
```

The output will provide details about the installed versions of Maven and Java, including their home locations:
```
Apache Maven 3.9.6 (bc0240f3c744dd6b6ec2920b3cd08dcc295161ae)
Maven home: C:\Program Files\Maven-3.9.6\apache-maven-3.9.6
Java version: 21.0.2, vendor: Eclipse Adoptium, runtime: C:\java_home
Default locale: en_IN, platform encoding: UTF-8
OS name: "windows 10", version: "10.0", arch: "amd64", family: "windows"
```

---

# Integrating Docker with Jenkins on Windows 10 🐳

## Prerequisites 🚀

Before you start, make sure you have the following:

1. **Docker**: Install Docker on your local system. In this context, Docker Desktop is installed on Windows 10.

## Plugins 🛠️

You'll need the following Jenkins plugins:

1. **Docker Pipeline**: This plugin allows you to build and use Docker containers from pipelines.
2. **Docker Plugin**: Integrates Jenkins with Docker.

### Installing the Docker Plugins on Jenkins:

1. Log in to your Jenkins dashboard.
2. Navigate to **Manage Jenkins** > **Manage Plugins**.
3. Search for the **Docker Pipeline** and **Docker** plugins and install them.

## Credentials Setup 🔑

1. Go to **Jenkins Dashboard** > **Manage Jenkins** > **Manage Credentials**.
2. Click on **(global)** under **Stores scoped to Jenkins**.
3. Click on **Add Credentials** on the left side.
4. In the **Kind** dropdown, select **Username with password**.
5. In the **Username** field, enter your Docker username, and in the **Password** field, enter your Docker token (instead of a password).
6. In the **ID** field, enter a unique ID for this credential (e.g., `dockerpwd`).
7. Click **OK** to save the credential.

After setting up everything, verify it using a pipeline, and make sure both Jenkins and Docker are running.

## Jenkinsfile Example 🚀

```groovy
pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
        stage("Verify Docker") {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerpwd', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        bat 'docker login --username %DOCKER_USERNAME% --password %DOCKER_PASSWORD%'
                        bat "docker version"
                        bat "docker ps"
                        bat "docker images"
                    }
                }
            }
        }
    }
}
```

---

# Installing Trivy and Integrating Kubernetes with Jenkins on Windows 10 🚀

## Trivy Installation Steps 🐳

1. **Check if Chocolatey package manager is installed**:
   - If not, install it.
   - [Chocolatey Installation Guide](https://chocolatey.org/install)

2. **Install Trivy using Chocolatey**:
   - Open a command prompt or PowerShell.
   - Run the command: `choco install trivy`
   - Verify the installation: `trivy version`
   - Usage: `trivy image <imagename>`

## Integrating Kubernetes with Jenkins 🔧

### Prerequisites:

1. **Install Kubernetes on your local system**:
   - The installation process varies depending on the operating system.
   - In this context, Kubernetes is installed using Docker Desktop.

2. **Gather necessary information**:
   - Collect Kubernetes URL, config, and CA certificate.
   - These files are typically located in the `.kube` directory.

### Jenkins Plugins:

1. **Kubernetes CLI Plugin**:
   - Configures `kubectl` for Kubernetes.
2. **Kubernetes Plugin**:
   - Integrates Jenkins with Kubernetes.

### Install the Kubernetes Plugins on Jenkins:

1. Log in to your Jenkins dashboard.
2. Navigate to **Manage Jenkins** > **Manage Plugins**.
3. Search for the **Kubernetes** plugin and the **Kubernetes CLI** plugin, and install them.

### Credentials Setup:

1. Create a **secret file credential** in Jenkins:
   - Go to **Jenkins Dashboard** > **Manage Jenkins** > **Manage Credentials**.
   - Click on **(global)** under **Stores scoped to Jenkins**.
   - Click on **Add Credentials** on the left side.
   - In the **Kind** dropdown, select **Secret file**.
   - Upload the config file (which is under the `.kube` directory).
   - In the **ID** field, enter a unique ID for this credential (e.g., `my-credentials`).
   - Click **OK** to save the credential.

### Jenkinsfile Example 🌟

```groovy
pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
        stage("Verify Kubernetes") {
            steps {
                withCredentials([file(credentialsId: 'config', variable: 'CA_CERTIFICATE')]) {
                    kubeconfig(
                        credentialsId: 'config',
                        serverUrl: '',
                        caCertificate: '%env.CA_CERTIFICATE%'
                    ) {
                        bat 'kubectl get node'
                        
                        // Additional steps or blocks
                    }
                }
            }
        }
    }
}
```




