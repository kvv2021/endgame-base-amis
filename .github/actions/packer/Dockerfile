FROM hashicorp/packer:light

RUN apk add --no-cache ansible
# Uncomment for DEBUG and comment the other, this keeps packer from removing the instance after its provisioned.
# ENTRYPOINT ["/bin/packer", "build", "-debug", "-on-error=abort"]

# Otherwise use this one
ENTRYPOINT ["/bin/packer", "build"]