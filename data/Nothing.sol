pragma solidity <=0.8;

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        uint256 c = a + b;
        if (c < a) return (false, 0);
        return (true, c);
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b > a) return (false, 0);
        return (true, a - b);
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) return (true, 0);
        uint256 c = a * b;
        if (c / a != b) return (false, 0);
        return (true, c);
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b == 0) return (false, 0);
        return (true, a / b);
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b == 0) return (false, 0);
        return (true, a % b);
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) return 0;
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division by zero");
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: modulo by zero");
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        return a - b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryDiv}.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        return a % b;
    }
}

contract Nothing { 
    using SafeMath for uint256;

    struct Lock {
        uint256 lockBalance;  
        uint256 onceUnlockValue;
        uint lastUnlockTime;  
        uint unlockInterval; 
    }

    string public name = "Nothing";
    string  public symbol = "NO";
    uint256 public totalSupply_ = 1000000000000e18;
    uint8   public decimals = 18;
    address public owner;

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );
    
    mapping(address => uint256) public balances;
    mapping(address => Lock) public locks; 
    mapping(address => mapping(address => uint256)) public allowed;

    constructor(address initAddress) public {
        balances[initAddress] = totalSupply_;
        owner = msg.sender;
    }

    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return ((balances[_owner]) + (locks[_owner].lockBalance));
    }

    function transferOwner(address _to) public returns (bool success) {
      
      require(msg.sender == owner);
      owner = _to;
      return true;
    }
    
    function _unlockIfRequired(address _owner) public returns (bool success) {
        // Lock storage lock = locks[_owner];
      if(locks[_owner].lockBalance != 0){
        uint number = (now - locks[_owner].lastUnlockTime) / (locks[_owner].unlockInterval);
        if(number >= 1){
          uint256 unlockValue = ((locks[_owner].onceUnlockValue) * number);
          if(unlockValue > locks[_owner].lockBalance){
            unlockValue = locks[_owner].lockBalance;
          }
          locks[_owner].lockBalance = ((locks[_owner].lockBalance) - unlockValue);
          balances[_owner] = ((balances[_owner]) + unlockValue);
          locks[_owner].lastUnlockTime = locks[_owner].lastUnlockTime+locks[_owner].unlockInterval * number;
        }
      }
      
      return true;
    }
    
    function transfer(address _to, uint256 _value) public returns (bool success) {
      _unlockIfRequired(msg.sender);
      _unlockIfRequired(_to);

      require(balances[msg.sender] >= _value);

      balances[msg.sender] = ((balances[msg.sender]) - _value);
      balances[_to] =  ((balances[_to]) + _value);
      emit Transfer(msg.sender, _to, _value);
      return true;
    }

    function _lockBalance(address _to,uint256 _lockValue,uint256 _onceUnlockValue,uint256 _unlockInterval) public returns (bool success){
      require(msg.sender == owner);
      require(balances[_to] >= _lockValue);

      balances[_to] = ((balances[_to]) - _lockValue);
      //Lock storage lock = locks[_to];
      locks[_to].lockBalance = ((locks[_to].lockBalance) + _lockValue);
      locks[_to].onceUnlockValue = _onceUnlockValue;
      if(locks[_to].lastUnlockTime==0){
        locks[_to].lastUnlockTime = now;
      }
      locks[_to].unlockInterval = _unlockInterval;
      return true;
    }

    function transferAndLock(address _to,uint256 _totalValue, uint256 _lockValue,uint256 _onceUnlockValue,uint256 _unlockInterval) public returns (bool success){
        require(msg.sender == owner);
        require(_totalValue >= _lockValue);

        transfer(_to,_totalValue);
        _lockBalance(_to,_lockValue,_onceUnlockValue,_unlockInterval);
        
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value; 
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);

        balances[_from] = ((balances[_from]) - _value);
        balances[_to] = ((balances[_to]) + _value);
        allowed[_from][msg.sender] =  ((allowed[_from][msg.sender]) - _value); 
        emit Transfer(_from, _to, _value);
        return true;
    }
    
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }
}
