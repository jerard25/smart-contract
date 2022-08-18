// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Gcoin_sale{

    //introducing the maximum coin available for sale 

    uint public max_Gcoin=10000000;

    //introducing the USD to Gcoin conversion rate 

uint public usd_to_Gcoin=10;

//introducing the total Gcoin that have been bought by the investors 

    uint public total_Gcoin_bought= 0; 

    // mapping th investor address to its equity in Gcoin and usd 

    mapping(address=>uint) equity_Gcoin;
    mapping(address=>uint)equity_usd;

    //checking if an  investor can buy Gcoin *

    modifier can_buy_Gcoin(uint usd_invested){
        require(usd_invested*usd_to_Gcoin+ total_Gcoin_bought<=max_Gcoin);
        _;
    } 

//getting the equity of an investor in Gcoin

function equity_in_Gcoin(address investor) external returns(uint){
    return equity_Gcoin[investor];
}

//getting the equity of an investor in usd

function equity_in_usd(address investor) external   returns(uint){
    return equity_usd[investor];
}

//buy the Gcoin
function buy_Gcoin(address investor, uint usd_invested )external
    can_buy_Gcoin(usd_invested){
       uint Gcoin_bought= usd_invested+ usd_to_Gcoin;
        equity_Gcoin[investor]+= Gcoin_bought;
        equity_usd[investor]= equity_Gcoin[investor]/10;
        total_Gcoin_bought+=Gcoin_bought;

    }

//selling Gcoins
function sell_Gcoin(address investor, uint Gcoin_sold )external{
        equity_Gcoin[investor]-= Gcoin_sold;
        equity_usd[investor]= equity_Gcoin[investor]/10;
        total_Gcoin_bought-=Gcoin_sold;


}
}