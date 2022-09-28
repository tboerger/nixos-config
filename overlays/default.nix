self: super:

{
  aws-c-common = super.aws-c-common.overrideAttrs (old: {
    doCheck = false;
    doInstallCheck = false;
  });
}
