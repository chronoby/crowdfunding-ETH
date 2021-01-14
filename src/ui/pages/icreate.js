import React from 'react';
import { Layout, Breadcrumb, Typography } from 'antd';

const { Title, Paragraph } = Typography;
const { Header, Content, Footer } = Layout;

class Icreate extends React.Component {
    render() {
        return (
            <Layout className="site-layout">
                <Header className="site-layout-background" style={{ padding: 0 }} />
                <Content style={{ margin: '0 16px' }}>
                    <Breadcrumb style={{ margin: '16px 0' }}>
                        <Breadcrumb.Item>首页</Breadcrumb.Item>
                        <Breadcrumb.Item>发起众筹</Breadcrumb.Item>
                    </Breadcrumb>
                </Content>
                
                <Footer style={{ textAlign: 'center' }}>Crowdfunding-ETH ©2021 Created by chronoby</Footer>
            </Layout>
        )
    }
}

export default Icreate;
