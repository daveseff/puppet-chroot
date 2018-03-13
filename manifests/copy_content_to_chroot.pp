# copy contents to chroot path
define chroot::copy_content_to_chroot($path, $contents) {
  $contents.each |$index, $content| {
    file {"${path}${content}":
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      source => $content,
      recurse => true,
    }
  }
}
