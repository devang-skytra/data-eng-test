# https://cloud.google.com/storage/docs/gsutil/commands/iam

# The iam set command sets the IAM policy for one or more buckets and / or objects. 
# It overwrites the current IAM policy that exists on a bucket (or object)

# The iam ch command incrementally updates IAM policies
gsutil iam ch serviceAccount:airbus-storage-reader-sa@research-3b366fd9.iam.gserviceaccount.com:ObjectCreator gs://kiwi-api-test