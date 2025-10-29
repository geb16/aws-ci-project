# AWS CI/CD Containerized Flask App

A professional example of an **end-to-end containerized Flask application** deployed on **AWS EC2** using **CodeDeploy** and **Docker**.  

**Key Highlights:**

- Fully automated **CI/CD pipeline** with lifecycle hooks:
  - Stop old container → Pull latest image → Start container → Health check
- Predictable, safe container management:
  - Fixed container names prevent port conflicts
  - Health checks ensure only healthy instances are marked successful
- Infrastructure-friendly:
  - Stops old containers automatically  
  - Works with public Docker Hub or private ECR  
  - Easy cost optimization: EC2 can be stopped when idle
- Simple, production-ready structure:
  - `scripts/` for deployment automation  
  - `src/flask_app/` for application code and Dockerfile  
  - `appspec.yml` orchestrates CodeDeploy hooks
---

**Live Demo:**  
Accessible at `http://<EC2_PUBLIC_IP>:5000/` (replace with your instance IP)  

**Purpose:**  
Showcases modern cloud DevOps practices:
- Containerization with Docker  
- Automated deployments via AWS CodeDeploy  
- Health-aware, repeatable, and safe CI/CD pipelines  

---

## Project Structure

```text
aws-ci-projects/
├── appspec.yml                # CodeDeploy hooks for lifecycle events
├── README.md
├── scripts/                   # Deployment scripts
│   ├── health_check.sh        # ValidateService health check
│   ├── start_container.sh     # Pull & start Docker container
│   ├── stop_container.sh      # Stop & remove old container
│   └── verify_container.sh    # Verify container is running
└── src/flask_app/             # Flask app source
    ├── Dockerfile             # Container build instructions
    ├── app.py                 # Flask application
    ├── appspec.yml            # Optional local appspec
    ├── buildspec.yml          # AWS CodeBuild build instructions
    ├── requirements.txt       # Python dependencies
    ├── start_container.sh     # App-specific start script (optional)
    └── stop_container.sh      # App-specific stop script (optional)
```
## Deployment Instructions
    - AWS account with EC2, CodeDeploy, CodePipeline access
    - EC2 instance with:Docker installed
    - IAM role for CodeDeploy with S3 read/write permissions
    - AWS CLI configured
    - Docker Hub account (or ECR) for storing images

## Deployment Flow

   1. Code Commit: Push code to GitHub or CodeCommit.
   2. CodePipeline: Triggers CodeBuild (optional) and CodeDeploy.
   3. CodeDeploy Hooks:
        - `ApplicationStop` → stop and remove any old container
        - `AfterInstall` → pull latest Docker image & start container
        - `ApplicationStart` → verify container is running
        - `ValidateService` → run health check (`/health`)
   4. Containerized Flask App runs on EC2 at port `5000`.

## Scripts overview  
`start_container.sh
`
 - Stops old container if exists
 - Pulls the latest Docker image
 - Runs new container on `0.0.0.0:5000`
 - Ensures automatic CI/CD updates

`stop_container.sh
`
 - Safely stops and removes existing container by name
 - Prevents port conflicts on redeploy

`verify_container.sh
`
 - Confirms container is running (used in ApplicationStart)

`health_check.sh`
 - Calls `http://localhost:5000/health`
 - Ensures CodeDeploy marks instance healthy

---

## Running Locally (Optional)
```bash
cd src/flask_app
docker build -t simple-flask-app:latest .
docker run -d -p 5000:5000 --name sample-flask-app simple-flask-app:latest
curl http://localhost:5000/       # Main route
curl http://localhost:5000/health # Health check
```
---

## Best Practices

 - Use fixed container names to avoid port conflicts.
 - Always pull the latest image to update deployments automatically.
 - Keep sensitive credentials (AWS keys, Docker passwords) out of Git; use **IAM roles**, **SSM Parameter Store**, or **Secrets Manage**r.
 - Run health checks to ensure deployments only mark healthy instances.
 - Stop or remove unused containers/images to save EC2 resources.
---
## Security & Cost Optimization
 - Stop EC2 instance when not in use.
 - Remove or prune Docker containers and images periodically.
 - Limit exposed ports; consider running behind a Load Balancer or VPC-only access.
---
## References

 - [AWS CodeDeploy Documentation↑](https://docs.aws.amazon.com/codedeploy/latest/userguide/welcome.html)

 - [Docker Official Documentation↑](https://docs.docker.com/)

 - [Flask Official Documentation↑](https://flask.palletsprojects.com/)