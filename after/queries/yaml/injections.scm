; extends
(block_mapping_pair
  key: (flow_node) @_pwsh
  (#any-of? @_pwsh "pwsh" "inlineScript")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "powershell")
    (#offset! @injection.content 0 1 0 0)))
