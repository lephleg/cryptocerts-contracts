# CryptoCerts Contracts

This repository contains the smart contracts of a proof of concept version of CryptoCerts, a decentralized academic certificate registry built on Ethereum. 

This project is written in [Solidity](https://docs.soliditylang.org/) utilizing [Ganache CLI](https://docs.nethereum.com/en/latest/ethereum-and-clients/ganache-cli/), [Truffle](https://www.trufflesuite.com/truffle) and [IPFS](https://ipfs.io/), along with a [React](https://reactjs.org/) web client application with [Redux](https://redux.js.org/) and [web3.js](https://github.com/ethereum/web3.js/).

For the client repository see [cryptocerts-client](https://github.com/lephleg/cryptocerts-client).

## Setup Instructions using Docker

### Prerequisites

To use the packaged environment you will need [Docker Desktop](https://www.docker.com/products/docker-desktop) for your operating system. Please ensure [Docker Compose](https://docs.docker.com/compose/install/) is also available.

### Steps
* Clone the contracts repository into a directory:
    ```
    $ git clone git@github.com:lephleg/cryptocerts-contracts.git .
    ```
* Clone the client repository in a subdirectory named `client`:
    ```
    $ git clone git@github.com:lephleg/cryptocerts-client.git client
    ```
* While remaining at the root directory, execute the following command to spin up the `ganache-cli` and `truffle` containers:
    ```
    $ docker-compose up -d
    ```
* Install contract dependencies using `npm` in the `truffle` container: 
    ```
    $ docker exec -it truffle npm install --silent
    ```
* In order to compile and deploy the contracts in Ganache use:
    ```
    $ docker exec -it truffle truffle migrate
    ```
* Write down the address of the newly deployed CryptoCerts contract found in the output of the previous command.
* Navigate to the `client` directory.
* Make a copy of the `.env.example` configuration file named `.env.local`:
    ```
    $ cp .env.example .env.local
    ```
* Paste the address of the CryptoCerts contract as the value of the `REACT_APP_CRYPTOCERTS_CONTRACT_ADDRESS` key in `.env.local`.
* While remaining in the `client` subdirectory spin up the `cryptocerts-client` application container along with the `ipfs` local node:
    ```
    $ docker-compose up -d
    ```
* Configure IPFS CORS policy to allow connections from localhost and restart container to apply the new configuration:
    ```
    $ docker exec -it ipfs ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["*"]'
    $ docker exec -it ipfs ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["GET", "POST"]'
    $ docker restart ipfs
    ```
* Point your browser to http://localhost:3000 in order to access the web client application.

## Available Accounts

Ganache CLI is configured to generate the following 10 Ethereum accounts credited with 100 ETH each on every run:

```
(0) 0xAC5a931d4b086923E6f73b8d90105Fc9b3E3acd3 (100 ETH)
(1) 0x9988244263D83901692fC61efe529357ED35c102 (100 ETH)
(2) 0x201eeCf56D7fAEEEB6dDec06ed576a4AC4288b5b (100 ETH)
(3) 0x917FFBe82B10F074745A40310d2d8316a8Ca0227 (100 ETH)
(4) 0x4Ef46738B67e684e893F2b0c7EF65a2cD44b7067 (100 ETH)
(5) 0x42F54b017c0FaD0789B0eCa4453EE76645e96DdA (100 ETH)
(6) 0xE811D3b95B5bb1Acf0f94768EA3014A9E7a0ebF4 (100 ETH)
(7) 0x0AdCF30784bFEd2E5cD5B11aE9673C25a3841f70 (100 ETH)
(8) 0x43FdF54294cDE9763288c610aCb815234A221A33 (100 ETH)
(9) 0x3c61695638E51fF5D89cA189A7E2017811224d73 (100 ETH)
```

Each account corresponds to a unique private key listed below:

```
(0) 0x93a3f09276dd607f7361f113434b6a3daf4f6af2f46600c6b6cb9205e4fc526e
(1) 0x045c5d8885d6a7d4753ce347a1743a3e5cf34c06821ffef037b11759e7e9c376
(2) 0x0c4115f6368b9192ef35c9b689893e61092ad8d445656828734cd63e3e035969
(3) 0x6e1ce3b2d9339ce0c2f736f6336a519ee1919c8d4d3db754db4c48d4cfee3b88
(4) 0x98e2b3148709edc5e0fbbe4dbd79fdf7f295592c32373fd21e6fb1dd96efb9b6
(5) 0x729fe8b46fab009d70eaf62fbcc6a274645d4129e0ac9e62e87a14b7797d8134
(6) 0x69233d052e1e717bc607c34f897cf8d5d734065bbdcc5c5ff4f3cd7bf2eede17
(7) 0x70184ae5af86ef3262f1c2184e23f60eb620b50fb81af56cc15b49f78db4ef5e
(8) 0xd8c11aeb25e7d7b61a1b71ee270aecb1b1f21820e85d7da9c98acacdba968c34
(9) 0xf27b697db66f4cf5c5b560e1cf4f7841b73fc5db2d763b2c0e932f969c50e0d7
```

All the above accounts can be imported to MetaMask or a BIP32-compatible wallet with the following seed:

```
bless job switch twice tattoo execute peace bounce erase trip innocent shed
```

Please note the above **are only used for development and test purposes**. A real case scenario would require each user to generate his own pair of keys and receive a sufficient balance from a faucet in order to transact with the contracts.

## Reset the blockchain records

In order to reset the blockchain records in Genache CLI and start from scratch use the following:

* Remove the `ganache-cli` container:
    ```
    $ docker rm -f ganache-cli
    ```
* Remove the `ganache_db` volume:
    ```
    $ docker volume rm ganache_db
    ```
* While being in project root, recreate the container:
    ```
    $ docker container up -d
    ```