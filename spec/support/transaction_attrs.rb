TEST_TRANSACTION_ATTRS = {
  private_key: Bitcoin::Key.from_base58('92xShwMuSXbHhwvN5X8xHG3pTnftyh5FXMPzbT1XDYRw6a6Vv2q'),
  sender_address: 'mybEmYUVLX45ReEpXmJDHYKge7xV9Nq8cv',
  amount: 150_000,
  recipient_address: 'mugwYJ1sKyr8EDDgXtoh8sdDQuNWKYNf88',
  unspents: [
    {
      'txHash' => "d1d871844aed3036fea483fe9e7f0eb5f87918602d512175b19f552134a12b8b",
      'index' => 0,
      'scriptPubKey' => ["76a914c641ae0233f58861892a585cd7d3164625c860cf88ac"].pack('H*'),
      'value' => 100_000
    },
    {
      'txHash' => "e1e5f8dde48f20598ab1aa404bd0ef90a3bdbfd5337e7c31ac11ce5cbd43fa70",
      'index' => 0,
      'scriptPubKey' => ["76a914c641ae0233f58861892a585cd7d3164625c860cf88ac"].pack('H*'),
      'value' => 50_000
    },
    {
      'txHash' => "fa069174aa9f122b6226577dd4102cab5364a8904305a93056160761edc1805a",
      'index' => 0,
      'scriptPubKey' => ["76a914c641ae0233f58861892a585cd7d3164625c860cf88ac"].pack('H*'),
      'value' => 10_000
    }
  ]
}
