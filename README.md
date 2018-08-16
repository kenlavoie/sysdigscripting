# sysdigscripting 

These two scripts will install a manager node, and then connect the worker nodes via the outputted join token. It will also install the Sydig agent, if you are licensed. Installing open source will be different.

Both were tested and deployed on AWS Ubuntu Xenial (16.04) Operation Systems. These are NOT designed to be used with AWS User Data, so please do not  copy and paste into there. AWS user data does not persist the environment variables. Please feel free to fork, and modify the exports to the appropriate path. I may add a version in the near future that allows this.

Deployment wise - this was copy/pasted into the appropriate instance. Then, `chmod +x <scriptname>` was done, and execution of the script was done via `. ./scriptname.sh`. This can be performed on both nodes 

For complete deployment, you will need your `AWS Access Key`,`AWS Secret Access Key`, `S3 Bucket to be used`, `AWS Region`, `Sysdig Access Key` 
