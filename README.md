# example-ruby-aws-lambda-functions
Example functions for automating various tasks using ruby-on-lambda to run the code on AWS Lambda.

This repository is a collection of functions that have been written to automate mundane tasks and run them on Amazon Web Services Lambda Serverless Computing.

https://aws.amazon.com/lambda/

To run these functions you will need to clone lorennorman's ruby-on-lambda project and replace the contents of the ```app``` folder with the contents of one of the folders underneath 'functions' in this project.

https://github.com/lorennorman/ruby-on-lambda

As noted in lorennorman's project, use of gems with natively compiled code will most likely not work on Lambda. So we kept the dependencies to a minimum for the functions.

## Why not write your Lambda functions in python, Node.js, or Java?

Because we have a bunch of Ruby code hanging around to perform these actions in and would rather just drop it into action than spend the time to rewrite them.
