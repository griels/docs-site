DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export today=`date +%Y%m%d_%H%M%S`
export output_dir="${DIR}/../sites/${today}"
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
mkdir -p ${output_dir}
open "file://${output_dir}"
echo "building in ${output_dir}"
antora generate ${PLAYBOOK_NAME}.yml --pull --clean --to-dir ${output_dir} &> ${PLAYBOOK_NAME}.log
echo "built in ${output_dir}"
