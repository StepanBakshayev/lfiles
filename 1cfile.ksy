meta:
  id: lcfile
  file-extension:
    - cf
    - epf
    - erf
  endian: le
seq:
  - id: header
    type: header
  - id: root
    type: root
types:
  hex16:
    seq:
      - id: value
        type: str
        encoding: ascii
        size: 8
      - id: space0
        contents: [0x20]
  hex32:
    seq:
      - id: value
        type: str
        encoding: ascii
        size: 8
      - id: space0
        contents: [0x20]
  root:
    seq:
      - id: block
        type: block
      - id: index
        size: block.length.value.to_i(16)
        type: elements
  elements:
    seq:
      - id: items
        type: element
        repeat: eos
        eos-error: true
        #repeat-until: _.closing != 0x7fffffff #[0xff, 0xff, 0xff, 0x7f]
        #repeat-expr: _root._io.size / _root.types.element.size
        #
        #include: false
  element:
    seq:
      - id: header_porinter
        type: u4
      - id: data_pointer
        type: u4
      - id: closing
        type: u4
        # contents: [0xff, 0xff, 0xff, 0x7f]
  block:
    seq:
      - id: prefix
        contents: [0x0d, 0x0a]
      - id: document_size
        type: hex32
      - id: length
        type: hex32
      - id: next
        type: hex32
      - id: suffix
        contents: [0x0d, 0x0a]
  header:
    seq:
      - id: vacant_block
        type: u4
      - id: default_block_size
        type: u4
      - id: unknown
        type: u4
      - id: unknown_zero
        type: u4

