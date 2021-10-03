set -e
isFailed=false

MANIFEST_FILES=`find "${MANIFESTS_PATH}" -type f \( -name "*.yml" -o -name "*.yaml" \)`

# validate all manifest files
for FILE in $MANIFEST_FILES
do
  validation_result=`opa eval -d "${POLICIES_PATH}" -i $FILE data.manifest.invalid --format=pretty`
  if [ "$validation_result" != "[]" ]; then
    echo "FAILED::$FILE::$validation_result"
    isFailed=true
  else
    echo "PASSED::$FILE"
  fi
done

# check failed -> non zero exit code
if [ "$isFailed" == "true" ];
then
  exit 1
fi