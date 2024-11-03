import React from "react";
import { Link } from "react-router-dom";

const Footer = () => {
  return (
    <footer>
      <p>Copyright Oregon EAD 2024</p>
      <Link to="/about">Sobre o MEDDIFLUX</Link>
    </footer>
  );
};

export default Footer;
