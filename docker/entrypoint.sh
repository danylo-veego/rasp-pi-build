#!/bin/bash
# Check if the .netrc file doesn't already exist and NETRC_LOGIN is provided

if [ -z "${NETRC_LOGIN}" ]; then
  echo "NETRC_LOGIN is not set, exiting..."
  exit 1
fi

if [ -z "${NETRC_PASSWORD}" ]; then
  echo "NETRC_PASSWORD is not set, exiting..."
  exit 1
fi

rm -f "${HOME}/.netrc"

echo "Creating .netrc file..."
cat <<EOF >"${HOME}/.netrc"
machine ${NETRC_MACHINE}
  login ${NETRC_LOGIN}
  password ${NETRC_PASSWORD}
EOF
chmod 600 "${HOME}/.netrc"

# Execute the command provided to the docker run
exec "$@"
