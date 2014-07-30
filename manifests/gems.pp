# class xldeploy::gems
class xldeploy::gems (
  $gem_hash      = $xldeploy::gem_hash,
  $gem_array     = $xldeploy::gem_array,
  $gem_use_local = $xldeploy::gem_use_local) {
  if $::pe_version != undef {
    $gem_provider = 'pe_gem'
  } else {
    $gem_provider = 'gem'
  }

  if str2bool($gem_use_local) {
    Xldeploy::Resources::Local_gem {
      provider => $gem_provider }

    create_resources(xldeploy::resources::local_gem, $gem_hash)

  } else {
    Package {
      provider => $gem_provider }

    package { [$gem_array]: ensure => present }
  }
}
