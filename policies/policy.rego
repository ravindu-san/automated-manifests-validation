package manifest

# invalid manifest if 'kind' field is null
invalid[msg]{
    is_null(input.kind)
    msg := "error::kind cannot be null"
}

# invalid manifest if the value of 'kind' field is not a string
invalid[msg]{
    not is_null(input.kind)
    not is_string(input.kind)
    msg := "error::'kind' must be a string"
}

# cannot use containers with 'latest' tag
invalid[msg]{
    container := input.spec.containers[_]
    endswith(container.image, ":latest")
    msg := "error::containers with 'latest' tag are not allowed"
}