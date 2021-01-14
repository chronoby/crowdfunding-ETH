import React from 'react';
import { Button, Layout, Menu, Breadcrumb } from 'antd';
import {
    LeftOutlined,
    ContactsOutlined,
    InteractionOutlined,
    FormOutlined,
    BarsOutlined,
    QuestionCircleOutlined
} from '@ant-design/icons';
import Home from './pages/home'
import Create from './pages/create'
import All from './pages/all'
import Icreate from "./pages/icreate"
import Participating from './pages/participating'
import Help from './pages/help'

import { BrowserRouter, Route, Link, Switch, Router } from 'react-router-dom'

const { Header, Content, Footer, Sider } = Layout;
const { SubMenu } = Menu;

class UI extends React.Component {
    state = {
        collapsed: false,
    };

    onCollapse = collapsed => {
        console.log(collapsed);
        this.setState({ collapsed });
    };

    render() {
        const { collapsed } = this.state;
        return (
            <Layout style={{ minHeight: '100vh' }}>
                <BrowserRouter>
                    <Sider collapsible collapsed={collapsed} onCollapse={this.onCollapse}>
                        <div className="logo" />
                        <Menu theme="dark" defaultSelectedKeys={['1']} mode="inline">
                            <Menu.Item key="1" icon={<LeftOutlined />}>
                                <Link to="/">
                                    首页
                                </Link>
                            </Menu.Item>
                            <Menu.Item key="2" icon={<FormOutlined />}>
                                <Link to="/create">
                                    发起众筹
                                </Link>
                            </Menu.Item>
                            <Menu.Item key="3" icon={<BarsOutlined />}>
                                <Link to="/all">
                                    所有众筹
                                </Link>
                            </Menu.Item>
                            <Menu.Item key="4" icon={<ContactsOutlined />}>
                                <Link to="/icreate">
                                    我发起的众筹
                                </Link>
                            </Menu.Item>
                            <Menu.Item key="5" icon={<InteractionOutlined />}>
                                <Link to="/participating">
                                    我投资的众筹
                                </Link>
                            </Menu.Item>
                            <Menu.Item key="6" icon={<QuestionCircleOutlined />}>
                                <Link to="/help">
                                    帮助
                                </Link>
                            </Menu.Item>
                        </Menu>
                    </Sider>
                    <Switch>
                        <Route path="/" exact component={Home} />
                        <Route path='/create' component={Create} />
                        <Route path='/all' component={All} />
                        <Route path='/icreate' component={Icreate} />
                        <Route path='/participating' component={Participating} />
                        <Route path='/Help' component={Help} />
                    </Switch>
                </BrowserRouter>
            </Layout>
        );
    }
}

export default UI;