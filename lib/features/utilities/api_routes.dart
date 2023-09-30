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
  static const placeOrder = "api/catalog/cart/place-order";

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
  static const getOrders = "api/catalog/order";

  //post urls
  static const createPost = "api/catalog/posts";
  static const getPosts = "api/catalog/posts?type=post";
  static const getProducts = "api/catalog/posts?type=product";
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
  static const transferFunds = "api/user/transfer";

  //Validate Address
  static const validateAddress = 'api/logistics/validate-user-address';

  //Fetch Courier
  static const fetchCourier = 'api/logistics/get-couriers';

  //Fetch banks
  static const fetchBanks = 'api/user/bank-details';

  //Update bank details
  static const updateBankDetail = 'api/user/save-account-number';
}
