#!/bin/bash
aws s3 sync /var/log s3://your-bucket-name/log-backup/
