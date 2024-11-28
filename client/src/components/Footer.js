import React from "react";
import { Link } from "react-router-dom";

const Footer = () => {
  return (
    <footer>
      <p>Copyright Time 2 2024</p>
      <Link to="/about">Sobre o Meddiflux</Link>
    </footer>
  );
};

export default Footer;
