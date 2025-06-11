#!/bin/bash
JENKINS_URL="http://jenkins.local/job/YourJobName/build?token=yourtoken"
curl -X POST $JENKINS_URL --user username:apitoken
