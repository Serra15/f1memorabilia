// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Importamos las librerias necesarias
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SpeedStars is ERC1155, ERC1155Burnable, Ownable {
    
    // Definimos las constantes
    uint256 public constant LLAVERO = 0;
    uint256 public constant TAZA = 1;
    uint256 public constant BANDERA = 2;
    uint256 public constant JUGUETE = 3;
    uint256 public constant CASCO = 4;

    // Creamos la función del constructor
    constructor() 
        ERC1155(
            "https://ipfs.io/ipfs/QmXcNPyPAiqQhoRaofW1nQpRsvABQ3aoRn5GAuMnoSAToS/{id}.json"
        )
        Ownable(msg.sender) // Establecemos el propietario inicial
    {
        _mint(msg.sender, LLAVERO, 10000, "");
        _mint(msg.sender, TAZA, 1000, "");
        _mint(msg.sender, BANDERA, 100, "");
        _mint(msg.sender, JUGUETE, 10, "");
        _mint(msg.sender, CASCO, 1, "");
    }

    // Sobreescribimos la función URI
    function uri(
        uint256 _tokenId
    ) public pure override returns (string memory){
        return 
            string(
                abi.encodePacked(
                    "https://ipfs.io/ipfs/QmXcNPyPAiqQhoRaofW1nQpRsvABQ3aoRn5GAuMnoSAToS/",
                    Strings.toString(_tokenId),
                    ".json"
                )
            );
    }

    // Crear URI para todo el contrato
    function contractURI() public pure returns (string memory) {
        return 
            "https://ipfs.io/ipfs/QmXcNPyPAiqQhoRaofW1nQpRsvABQ3aoRn5GAuMnoSAToS/collection.json";
    }

    // El dueño puede distribuir tokens 
    function airdrop(
        uint256 tokenId,
        address[] calldata recipients
    ) external onlyOwner {
        for (uint i = 0; i < recipients.length; i++) {
            _safeTransferFrom(msg.sender, recipients[i], tokenId, 1, "");
        }
    }
}

