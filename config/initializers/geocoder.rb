Geocoder.configure(
    :timeout      => 30,
    :lookup       => :google,
    :units        => :mi,
    :language     => :en,
    :use_https    => true,
    :http_proxy   => '',
    :https_proxy  => '',
    :api_key      => ENV["GOOGLE_API_KEY"],
    :cache        => nil,
    :cache_prefix => "geocoder"
    )
