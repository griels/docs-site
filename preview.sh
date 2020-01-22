DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export output_dir="${DIR}/public"
echo "deleting output_dir ${output_dir}"
rm -rf ${output_dir}
export cache="${DIR}/.cache"
export PLAYBOOK_NAME="staging-antora-playbook"
if [ "$1" == "rebuild" ]; then
echo "deleting cache: ${cache}"
rm -rf ${cache}
fi
if [ "$1" == "docker" ]; then
  docker run --rm -ti \
  --publish 8080:80 \
  --mount type=bind,source=/Users/ellis_breen/root/workspaces/couchbase/docs-site,target=/src,readonly \
  spjmurray/couchbase-antora-preview:1.1.0 \
  --repo url=/,branches=master:1.0.x,start_path=docs/user
fi
echo "building"
antora generate ${PLAYBOOK_NAME}.yml --cache-dir=${cache} &> ${PLAYBOOK_NAME}.log

