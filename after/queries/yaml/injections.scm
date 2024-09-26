; extends
(block_mapping_pair
  key: (flow_node) @_pwsh
  (#any-of? @_pwsh "pwsh")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "powershell")
    (#offset! @injection.content 0 1 0 0)))

(block_mapping_pair
  key: (flow_node) @_pwsh
  (#any-of? @_pwsh "inlineScript")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "bash")
    (#offset! @injection.content 0 1 0 0)))
