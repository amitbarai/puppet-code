# Class: profile::heira_test2
#
#
class profile::heira_test2 (
    $aml_tenants       = lookup('sironaml::aml_tenants')
)
{
  $aml_tenants.each |$aml_tenant_name, $aml_tenant| {
    $_amljndiname   = $aml_tenant[aml_web_client_jndi_name]
    $_amljndiurl    = $aml_tenant[aml_jdbc_db_url]
    $_amljndidbuser = $aml_tenant[aml_db_login_user]
    $_amljndidbpass = $aml_tenant[aml_db_login_passwd]
}

