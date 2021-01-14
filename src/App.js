import React from 'react';
import { Button, Layout, Menu, Breadcrumb } from 'antd';
import UI from './ui/ui';
import './App.css';

const { Header, Content, Footer, Sider } = Layout;
const { SubMenu } = Menu;

class App extends React.Component {
  render() {
    return (
      <UI></UI>
    );
  }
}

export default App;