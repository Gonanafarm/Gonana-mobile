class ApiRoute {
  //user urls
  static const fetchUserByEmail = "api/user/get-by-email";
  static const fetchUserById = "api/user/find-by-id";
  static const putUpdateProfile = "api/profile/update-profile";
  static const uploadProfilePhoto = "api/user/update-image";

  //cart urls
  static const fetchCart = "api/catalog/cart";
  static const fetchCartItem = "api/catalog/cart";
  static const addToCart = "api/catalog/cart";
  static const updateCart = "api/catalog/cart";
  static const getRates = "api/catalog/cart/get-rates";
  static const placeOrder = "api/catalog/cart/place-order";
  static const cryptoPlaceOrder = "api/catalog/cart/pay-with-eth";

  //
  static const fetchNotifications = "api/user/notifications";

  //auth urls
  static const login = "api/auth/login";
  static const activate = "api/auth/activate";
  static const otpVerification = "api/auth/verify-otp";
  static const resendOtp = "api/auth/resend-otp";
  static const updateProfile = "api/auth/update-profile";
  static const resendActivationCredentials =
      "api/auth/resend-activation-credentials";
  static const me = "api/auth/me";

  // order urls
  static const getIncomingOrders = "api/catalog/orders/incoming";
  static const getOutgoingOrders = "api/catalog/orders/outgoing";
  static const confirmSentOrder = "api/catalog/orders/confirm-sent";
  static const confirmReceivedOrder = "api/catalog/orders/confirm-received";
  static const complain = "api/catalog/orders/complaint";

  //post urls
  static const createPost = "api/catalog/posts";
  static const getPosts = "api/catalog/posts?type=post";
  static const likePost = "api/catalog/posts/like";
  static const unlikePost = "api/catalog/posts/unlike";
  static const comment = "api/catalog/posts/comment";
  static const getComments = "api/catalog/posts/post-comments";

  // static const getProducts = "api/catalog/posts?$page=1&limit=2&type=product";
  static const getUserProduct = "api/catalog/posts/user-products?type=product";
  static const getDiscountedProducts = "api/catalog/posts/discounted-products";
  static const getPostItem = "api/catalog/posts";
  static const getProductItem = "api/catalog/posts?type=product";
  static const updatePost = "api/catalog/posts";
  static const updatePrice = "api/catalog/posts/update-amount";
  static const deleteProduct = "api/catalog/posts";

  //password auth urls
  static const forgottenPassword = 'api/auth/forgotten-password';
  static const resetPassword = 'api/auth/reset-password';
  static const verifyPasswordotp = 'api/auth/VerifyPasswordOtp';
  static const resetPasscode = 'api/profile/reset-passcode';
  static const verifyResetOtp = 'api/profile/verify-passcode-otp';

  static const registerPlayerId = 'api/user/update-player-id';

  //Taxonomy urls
  static const getTaxonomy = "api/catalog/taxonomy";
  static const postTaxonomy = "api/catalog/taxonomy";
  static const deleteTaxonomy = "api/catalog/taxonomy";
  static const getTaxonomyItem = "api/catalog/taxonomy";
  static const putTaxonomyItem = "api/catalog/taxonomy";

  // delete url
  static const deletePost = "api/catalog/posts";
  static const deleteAccount = "api/auth/delete";

  //passcode urls
  static const createPasscode = "api/profile/create-passcode";
  static const verifyPasscode = "api/profile/verify-passcode";

  //Payment url
  static const transferFunds = "api/transaction/transfer";
  static const transferCrypto = "api/transaction/send-eth";

  //Validate Address
  static const validateAddress = 'api/logistics/validate-user-address';
  static const updateAddress = 'api/logistics/update-user-address';

  //Fetch Courier
  static const fetchCourier = 'api/logistics/get-couriers';

  //Fetch banks
  static const fetchBanks = 'api/transaction/bank-details';

  //Update bank details
  static const updateBankDetail = 'api/transaction/save-account-number';

  // verify BVN
  static const verifyKyc = 'api/transaction/kyc';
  static const verifyBVN = 'api/transaction/create-virtual-account';
  static const recoverBvn = 'api/transaction/recover-virtual-account';

  // get wallet balance
  static const getWalletBalance = 'api/transaction/user-balance';
  static const getCryptoWalletBalance = 'api/transaction/crypto-balance';

  // get wallet transactions
  static const getWalletTransactions = 'api/transaction/user-transactions';
  static const gonanaTransfer = 'api/transaction/transfer-to-user';

  //search products
  static const searchProduct = 'api/catalog/posts?type=product&title=';
}
