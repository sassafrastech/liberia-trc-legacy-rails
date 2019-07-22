module Visual
  def path(version, pub = true, check_normal = true)
    p = File.join(pub ? "/" : "#{RAILS_ROOT}/public", base_path, "#{version}s", "#{id}." + extension(version))
    
    # Return the path to the original if photo doesn't have a normal version.
    check_normal && version == "normal" && !has_normal? ? path("original", pub) : p
  end
  def has_normal?
    File.exists?(path("normal", false, false))
  end
  def filesize
    (File.size(path("original", false))/1024).floor
  end
end
