                    Internet
                       |
                Internet Gateway
                       |
              Public Application ALB
                       |
              ┌────────┴────────┐
              |                 |
          Web EC2 #1        Web EC2 #2
          Nginx + React     Nginx + React
              |                 |
              └────────┬────────┘
                       |
                Internal ALB
                       |
              ┌────────┴────────┐
              |                 |
          App EC2 #1        App EC2 #2
          Node.js API       Node.js API
              |                 |
              └────────┬────────┘
                       |
                 RDS PostgreSQL


We will eventually replace the individual ec2 instances with Auto Scaling groups , so production architecture becomes

Internet
   |
Internet Gateway
   |
Public ALB
   |
Web ASG
(min 2 / desired 2 / max 4)
   |
Internal ALB
   |
App ASG
(min 2 / desired 2 / max 4)
   |
RDS PostgreSQL
