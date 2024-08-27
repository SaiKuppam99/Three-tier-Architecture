# assignment_poc
Assignment created for poc

<h2>To run this project:[choose the environment accordingly]</h2>

terraform init -backend-config=environments/dev/backend.config <br>
terraform plan -var-file=environments/dev/variables.tfvars  
terraform apply -var-file=environments/dev/variables.tfvars  --auto-approve=true


The DB connection files for Lambda are placed in S3 bucket as ZIP in my S3 bucket. But the same can be found in a folder called "python_codes_db"<br>

The HTML web UI is kept in folder "html_web_app_files" Please change the line no: 13 [GET] and 30 [POST] as per the new API generated


Put all your required data in environments --> dev ---> variables.tfvars


GET Message Tested API:
------------------------
https://github.com/ashishsarkar/assignment_poc/blob/main/GET_Message.PNG



POST Message Tested API:
--------------------------
https://github.com/ashishsarkar/assignment_poc/blob/main/POST_Message.PNG