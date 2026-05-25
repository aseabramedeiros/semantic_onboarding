% ===== KOA Combined Output | contract_id: contrato_ocs_0218_2023 =====

% ===== 1) UFO Ontology =====
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY EM PROLOG
% Inspirada em UFO-L + UFO-S + Service Contract Ontology (Griffo et al., 2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% META-ESTRUTURA (TBox: classes, especializações, relações entre classes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicados básicos de metamodelo
class(C).          % C é uma classe ontológica
subclass_of(C, P). % C é subclasse de P
disjoint(C1, C2).  % C1 e C2 são disjuntas conceitualmente

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Núcleo UFO-A / UFO-C simplificado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(agent).           % agente (pessoa, organização etc.)
class(relator).         % relator genérico
class(moment).          % propriedade/momento (trope no sentido do UFO)

class(social_relator).
class(legal_relator).

subclass_of(social_relator, relator).
subclass_of(legal_relator, social_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEGAL MOMENTS E LEGAL RELATORS (UFO-L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(legal_moment).
class(legal_entitlement).      % vantagens jurídicas
class(legal_burden_or_lack).  % ônus / falta de prerrogativa

subclass_of(legal_entitlement, legal_moment).
subclass_of(legal_burden_or_lack, legal_moment).

% Tipos de legal relators
class(simple_legal_relator).
class(complex_legal_relator).

subclass_of(simple_legal_relator, legal_relator).
subclass_of(complex_legal_relator, legal_relator).

% ---------------------------------------------------------------------------
% Right / Duty
% ---------------------------------------------------------------------------

class(right).
class(right_to_action).
class(right_to_omission).

class(duty).
class(duty_to_act).
class(duty_to_omit).

subclass_of(right, legal_entitlement).
subclass_of(right_to_action, right).
subclass_of(right_to_omission, right).

subclass_of(duty, legal_burden_or_lack).
subclass_of(duty_to_act, duty).
subclass_of(duty_to_omit, duty).

% ---------------------------------------------------------------------------
% NoRight / Permission
% ---------------------------------------------------------------------------

class(no_right).
class(no_right_to_action).
class(no_right_to_omission).

class(permission).
class(permission_to_act).
class(permission_to_omit).

subclass_of(no_right, legal_burden_or_lack).
subclass_of(no_right_to_action, no_right).
subclass_of(no_right_to_omission, no_right).

subclass_of(permission, legal_entitlement).
subclass_of(permission_to_act, permission).
subclass_of(permission_to_omit, permission).

% ---------------------------------------------------------------------------
% Power / Subjection (Liability)
% ---------------------------------------------------------------------------

class(power).
class(subjection).

subclass_of(power, legal_entitlement).
subclass_of(subjection, legal_burden_or_lack).

% ---------------------------------------------------------------------------
% Disability / Immunity
% ---------------------------------------------------------------------------

class(disability).
class(immunity).

subclass_of(disability, legal_burden_or_lack).
subclass_of(immunity, legal_entitlement).

% ---------------------------------------------------------------------------
% Liberty (liberdade desprotegida como complex legal relator)
% ---------------------------------------------------------------------------

class(liberty_relator).
subclass_of(liberty_relator, complex_legal_relator).

% ---------------------------------------------------------------------------
% Tipos de Simple Legal Relator (pares correlatos)
% ---------------------------------------------------------------------------

class(right_duty_relator).
class(noright_permission_relator).
class(power_subjection_relator).
class(disability_immunity_relator).

subclass_of(right_duty_relator, simple_legal_relator).
subclass_of(noright_permission_relator, simple_legal_relator).
subclass_of(power_subjection_relator, simple_legal_relator).
subclass_of(disability_immunity_relator, simple_legal_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CORRELAÇÃO ENTRE LEGAL MOMENTS (Hohfeld + Alexy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Correlatos em nível de classe
correlates(right_to_action,   duty_to_act).
correlates(duty_to_act,       right_to_action).

correlates(right_to_omission, duty_to_omit).
correlates(duty_to_omit,      right_to_omission).

correlates(permission_to_act,     no_right_to_action).
correlates(no_right_to_action,    permission_to_act).

correlates(permission_to_omit,    no_right_to_omission).
correlates(no_right_to_omission,  permission_to_omit).

correlates(power,      subjection).
correlates(subjection, power).

correlates(disability, immunity).
correlates(immunity,   disability).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE RELATIONS E SERVICE CONTRACTS (núcleo UFO-S simplificado)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(service_relation).
class(service_agreement).
class(legal_service_agreement).

subclass_of(service_agreement, service_relation).
subclass_of(legal_service_agreement, service_agreement).

% Papéis em relações de serviço
class(service_provider_role).
class(target_customer_role).
class(hired_service_provider_role).
class(service_customer_role).

subclass_of(hired_service_provider_role, service_provider_role).
subclass_of(service_customer_role,       target_customer_role).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY (Fig. 4 do artigo)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Em um Legal Service Agreement, cada parte tem Entitlements e Burdens/Lacks
class(hsp_entitlement).      % Hired Service Provider Entitlement
class(hsp_burden_or_lack).   % Hired Service Provider Burden/Lack
class(sc_entitlement).       % Service Customer Entitlement
class(sc_burden_or_lack).    % Service Customer Burden/Lack

subclass_of(hsp_entitlement, legal_entitlement).
subclass_of(sc_entitlement,  legal_entitlement).

subclass_of(hsp_burden_or_lack, legal_burden_or_lack).
subclass_of(sc_burden_or_lack,  legal_burden_or_lack).

% Composição: um Legal Service Agreement é composto de legal moments
% associados a cada papel (provider x customer).
relator_component(legal_service_agreement, hsp_entitlement).
relator_component(legal_service_agreement, hsp_burden_or_lack).
relator_component(legal_service_agreement, sc_entitlement).
relator_component(legal_service_agreement, sc_burden_or_lack).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESQUEMA PARA INSTÂNCIAS (ABox): AGENTES, ACORDOS, CLÁUSULAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% instance_of(Instancia, Classe).
% Você vai usar isso para criar indivíduos (contratos, cláusulas, agentes...).

:- dynamic instance_of/2.
:- dynamic plays_role/3.
:- dynamic legal_relation_instance/4.
:- dynamic clause_of/2.

% plays_role(Agente, Papel, Acordo).
% Ex.: plays_role(aws, hired_service_provider_role, aws_sns_agreement).
%      plays_role(cliente_x, service_customer_role, aws_sns_agreement).
plays_role(Agent, Role, Agreement).

% clause_of(ClauseId, Agreement).
% ClauseId é uma cláusula (ou grupo de cláusulas) de um acordo específico.
clause_of(ClauseId, Agreement).

% legal_relation_instance(ClauseId, LegalMoment, Bearer, Action).
%
% ClauseId   - identificador da cláusula
% LegalMoment- classe do momento jurídico (duty_to_omit, power, immunity...)
% Bearer     - quem tem esse momento (agente ou papel)
% Action     - ação/omissão ou descrição da conduta
%
% Exemplos (para você popular depois, inspirados no artigo):
% legal_relation_instance(clause_17_1, duty_to_omit, customer, share_service_with_third_parties).
% legal_relation_instance(clause_17_1, right_to_omission, provider, share_service_with_third_parties).

legal_relation_instance(ClauseId, LegalMomentClass, Bearer, Action) :-
    clause_of(ClauseId, _Agreement),
    class(LegalMomentClass),
    (   atom(Bearer)
    ;   plays_role(Bearer, _, _)
    ),
    atom(Action).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REGRAS AUXILIARES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fecho transitivo de subclass_of/2
subclass_of_trans(C, P) :-
    subclass_of(C, P).
subclass_of_trans(C, P) :-
    subclass_of(C, X),
    subclass_of_trans(X, P).

% is_a(Inst, Classe) — verifica se Inst é instância (direta ou indireta) de Classe
is_a(Inst, Classe) :-
    instance_of(Inst, C0),
    (   C0 = Classe
    ;   subclass_of_trans(C0, Classe)
    ).

% um legal_moment é um entitlement se a classe dele cai abaixo de legal_entitlement
is_entitlement(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_entitlement).

% um legal_moment é um burden/lack se cai abaixo de legal_burden_or_lack
is_burden_or_lack(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_burden_or_lack).

% Dado um LegalMomentClass, encontrar seu correlato (em termos de classe)
correlative_class(LMClass, CorrelateClass) :-
    correlates(LMClass, CorrelateClass).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIM DA ONTOLOGIA BASE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ===== 2) Generated UFO ABox =====
% UFO-only grounding generated from: KOA_Contrato_OCS_218_2023_-_Lotus_ICT.pl
% contract_id: contrato_ocs_0218_2023

instance_of(contrato_ocs_0218_2023, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(lotus_ict_empreendimentos_s_a, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_0218_2023).
plays_role(lotus_ict_empreendimentos_s_a, hired_service_provider_role, contrato_ocs_0218_2023).

clause_of(clausula_primeira_objeto, contrato_ocs_0218_2023).
clause_of(clausula_segunda_vigencia, contrato_ocs_0218_2023).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_0218_2023).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_0218_2023).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_0218_2023).
clause_of(clausula_sexta_preco, contrato_ocs_0218_2023).
clause_of(clausula_setima_pagamento, contrato_ocs_0218_2023).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_0218_2023).
clause_of(clausula_decima_garantia_contratual, contrato_ocs_0218_2023).
clause_of(clausula_decima_terceira_sigilo_informacoes, contrato_ocs_0218_2023).
clause_of(clausula_decima_quarta_acesso_protecao_dados_pessoais, contrato_ocs_0218_2023).
clause_of(clausula_decima_quinta_obrigações_bndes, contrato_ocs_0218_2023).
clause_of(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, contrato_ocs_0218_2023).
clause_of(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, contrato_ocs_0218_2023).
clause_of(clausula_decima_oitava_penalidades, contrato_ocs_0218_2023).
clause_of(clausula_decima_nona_alteracoes_contratuais, contrato_ocs_0218_2023).
clause_of(clausula_vigesima_extincao_contrato, contrato_ocs_0218_2023).
clause_of(clausula_vigesima_primeira_disposicoes_finais, contrato_ocs_0218_2023).
clause_of(clausula_vigesima_segunda_foro, contrato_ocs_0218_2023).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_0218_2023).
clause_of(clausula_decima_primeira_obrigações_contratado, contrato_ocs_0218_2023).
clause_of(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, contrato_ocs_0218_2023).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, lotus_ict_empreendimentos_s_a, provide_technical_support).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_technical_support).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, lotus_ict_empreendimentos_s_a, present_manifestation_on_extension).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, lotus_ict_empreendimentos_s_a, communicate_interest_regarding_extension).
legal_relation_instance(clausula_segunda_vigencia, subjection, lotus_ict_empreendimentos_s_a, subject_to_penalties_for_refusal).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, lotus_ict_empreendimentos_s_a, execute_contract_according_to_specifications).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, expect_execution_according_to_specifications).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, lotus_ict_empreendimentos_s_a, execute_services_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_price_reduction_index).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, lotus_ict_empreendimentos_s_a, be_subject_to_price_reduction_index).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_service_execution_according_to_standards).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_quinta_recebimento_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_sexta_preco, no_right_to_action, lotus_ict_empreendimentos_s_a, receive_indemnification).
legal_relation_instance(clausula_sexta_preco, duty_to_act, lotus_ict_empreendimentos_s_a, bear_onus_of_quantification_errors).
legal_relation_instance(clausula_sexta_preco, right_to_action, lotus_ict_empreendimentos_s_a, receive_payment).
legal_relation_instance(clausula_sexta_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_party).
legal_relation_instance(clausula_sexta_preco, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, reduce_payments).
legal_relation_instance(clausula_sexta_preco, duty_to_act, lotus_ict_empreendimentos_s_a, execute_contract_object).
legal_relation_instance(clausula_sexta_preco, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, partially_execute_and_receive).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, lotus_ict_empreendimentos_s_a, present_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, lotus_ict_empreendimentos_s_a, provide_supporting_documents).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_payments).
legal_relation_instance(clausula_setima_pagamento, right_to_action, lotus_ict_empreendimentos_s_a, receive_payment).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, reject_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_values).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, lotus_ict_empreendimentos_s_a, provide_cadastro_municipal).
legal_relation_instance(clausula_setima_pagamento, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_late_iss_collection).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_price_readjustment).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, initiate_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, negotiate_price_reduction).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, retroactive_payment_after_deadline).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, present_information_price_reduction).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_price_readjustment_revision_before_end).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_readjustment_revision_request).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_readjustment_revision_request_analysis).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, negotiate_prices_if_readjustment_too_high).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, lotus_ict_empreendimentos_s_a, provide_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, lotus_ict_empreendimentos_s_a, obtain_guarantor_agreement).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, lotus_ict_empreendimentos_s_a, notify_guarantor).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, lotus_ict_empreendimentos_s_a, provide_additional_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extend_guarantee_presentation_deadline).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, lotus_ict_empreendimentos_s_a, obtain_new_guarantee).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, lotus_ict_empreendimentos_s_a, comply_with_bndes_information_security_policy).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_omit, lotus_ict_empreendimentos_s_a, not_access_confidential_information_without_authorization).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, lotus_ict_empreendimentos_s_a, maintain_confidentiality_of_information).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, lotus_ict_empreendimentos_s_a, limit_access_to_information).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, lotus_ict_empreendimentos_s_a, inform_bndes_of_confidentiality_breaches).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, lotus_ict_empreendimentos_s_a, return_bndes_property).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, lotus_ict_empreendimentos_s_a, present_confidentiality_agreements).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, lotus_ict_empreendimentos_s_a, observe_terms_of_confidentiality).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, protect_freedom_privacy_rights).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, lotus_ict_empreendimentos_s_a, obtain_consent_data_holders).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, right_of_recourse).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, lotus_ict_empreendimentos_s_a, provide_channel_for_data_access).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, lotus_ict_empreendimentos_s_a, inform_bndes_data_requests).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, lotus_ict_empreendimentos_s_a, maintain_data_treatment_records).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, lotus_ict_empreendimentos_s_a, communicate_data_breaches).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, lotus_ict_empreendimentos_s_a, eliminate_personal_data).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_additional_data).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payments_to_contracted).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager_substitute).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_inspector).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_receiving_committee).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_access_to_ethics_code).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_necessary_info).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_administrative_procedure).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_penalty).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, duty_to_act, lotus_ict_empreendimentos_s_a, prove_absence_of_sanctioning_decision).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_contract_execution).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_proof_of_absence_of_sanctioning_decision).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, disability, lotus_ict_empreendimentos_s_a, continue_contract_execution_after_sanction).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, lotus_ict_empreendimentos_s_a, assign_contract_or_credit).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, lotus_ict_empreendimentos_s_a, issue_credit_title).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, lotus_ict_empreendimentos_s_a, subcontract_work).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, subjection, lotus_ict_empreendimentos_s_a, obtain_bndes_approval).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, duty_to_act, lotus_ict_empreendimentos_s_a, maintain_contractual_terms).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, permission_to_act, lotus_ict_empreendimentos_s_a, corporate_restructuring).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_contractual_risks).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, right_to_action, lotus_ict_empreendimentos_s_a, receive_credits).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, duty_to_act, unknown, execute_contract).
legal_relation_instance(clausula_decima_oitava_penalidades, subjection, lotus_ict_empreendimentos_s_a, subjected_to_penalties).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_oitava_penalidades, right_to_action, lotus_ict_empreendimentos_s_a, request_reconsideration_or_appeal).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_credits).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alter_contract).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, compensate_for_damages_caused_by_refusal_to_alter).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_alteration).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, no_right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_formalization_of_contract_alteration).
legal_relation_instance(clausula_vigesima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_consensually).
legal_relation_instance(clausula_vigesima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_due_to_bankruptcy).
legal_relation_instance(clausula_vigesima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_due_to_loss_of_qualification).
legal_relation_instance(clausula_vigesima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_due_to_union_sanction).
legal_relation_instance(clausula_vigesima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_due_to_dissolution).
legal_relation_instance(clausula_vigesima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_due_to_force_majeure).
legal_relation_instance(clausula_vigesima_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_written_notice_of_termination).
legal_relation_instance(clausula_vigesima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_for_breach).
legal_relation_instance(clausula_vigesima_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_of_breach_and_provide_opportunity_to_cure).
legal_relation_instance(clausula_vigesima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_contract_execution).
legal_relation_instance(clausula_vigesima_primeira_disposicoes_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_strict_compliance_after_omission).
legal_relation_instance(clausula_vigesima_primeira_disposicoes_finais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights_any_time).
legal_relation_instance(clausula_vigesima_primeira_disposicoes_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_contract_rights).
legal_relation_instance(clausula_vigesima_segunda_foro, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_litigation_elsewhere).
legal_relation_instance(clausula_vigesima_segunda_foro, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, sue_elsewhere).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_omit, lotus_ict_empreendimentos_s_a, omit_requesting_additives).
legal_relation_instance(clausula_nona_matriz_riscos, no_right_to_action, lotus_ict_empreendimentos_s_a, not_right_to_request_additives).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, lotus_ict_empreendimentos_s_a, respect_economic_financial_balance_clause).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, lotus_ict_empreendimentos_s_a, maintain_habilitation_conditions).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, lotus_ict_empreendimentos_s_a, communicate_penalty_imposition).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, lotus_ict_empreendimentos_s_a, repair_object).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, lotus_ict_empreendimentos_s_a, repair_damages).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, lotus_ict_empreendimentos_s_a, pay_charges_and_taxes).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, lotus_ict_empreendimentos_s_a, assume_responsibility_for_onus).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, lotus_ict_empreendimentos_s_a, exclude_from_simples_nacional).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, lotus_ict_empreendimentos_s_a, permit_inspections).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, lotus_ict_empreendimentos_s_a, obey_instructions).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, lotus_ict_empreendimentos_s_a, designate_representative).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, lotus_ict_empreendimentos_s_a, maintain_integrity_public_private).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, lotus_ict_empreendimentos_s_a, act_good_faith_morality).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, lotus_ict_empreendimentos_s_a, conduct_ethically_and_responsibly).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_omit, lotus_ict_empreendimentos_s_a, not_offer_undue_advantage).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, lotus_ict_empreendimentos_s_a, prevent_favoritism_bndes_employees).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_omit, lotus_ict_empreendimentos_s_a, not_allocate_relatives_of_bndes_employees).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, lotus_ict_empreendimentos_s_a, observe_policies_and_code_of_ethics).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, lotus_ict_empreendimentos_s_a, adopt_good_practices_sustainability).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, lotus_ict_empreendimentos_s_a, inform_bndes_conflict_of_interest).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, lotus_ict_empreendimentos_s_a, notify_bndes_investigation).

% --- Action catalog (local to this contract grounding) ---
action_type(act_good_faith_morality).
action_label(act_good_faith_morality, 'Act in good faith and morality').
action_type(adopt_good_practices_sustainability).
action_label(adopt_good_practices_sustainability, 'Adopt sustainability practices').
action_type(alter_contract).
action_label(alter_contract, 'Alter contract').
action_type(analyze_contractual_risks).
action_label(analyze_contractual_risks, 'Right to analyze risks').
action_type(analyze_readjustment_revision_request).
action_label(analyze_readjustment_revision_request, 'Analyze readjustment revision request').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(apply_price_reduction_index).
action_label(apply_price_reduction_index, 'Apply price reduction index').
action_type(assign_contract_or_credit).
action_label(assign_contract_or_credit, 'No right to assign contract/credit').
action_type(assume_responsibility_for_onus).
action_label(assume_responsibility_for_onus, 'Assume responsibility for onus').
action_type(assume_technical_administrative_responsibility).
action_label(assume_technical_administrative_responsibility, 'Assume technical responsibility').
action_type(attend_to_administration_demands).
action_label(attend_to_administration_demands, 'Attend to admin demands').
action_type(be_subject_to_price_reduction_index).
action_label(be_subject_to_price_reduction_index, 'Be subject to price reduction index').
action_type(bear_onus_of_quantification_errors).
action_label(bear_onus_of_quantification_errors, 'Bear onus of quantification errors').
action_type(communicate_administrative_procedure).
action_label(communicate_administrative_procedure, 'Communicate admin procedure').
action_type(communicate_data_breaches).
action_label(communicate_data_breaches, 'Communicate data breaches').
action_type(communicate_instructions).
action_label(communicate_instructions, 'Communicate instructions').
action_type(communicate_interest_regarding_extension).
action_label(communicate_interest_regarding_extension, 'Communicate interest in extension').
action_type(communicate_penalty).
action_label(communicate_penalty, 'Communicate penalty').
action_type(communicate_penalty_imposition).
action_label(communicate_penalty_imposition, 'Communicate penalty').
action_type(compensate_for_damages_caused_by_refusal_to_alter).
action_label(compensate_for_damages_caused_by_refusal_to_alter, 'Compensate damages').
action_type(comply_with_bndes_information_security_policy).
action_label(comply_with_bndes_information_security_policy, 'Comply with BNDES security policy').
action_type(comply_with_regulations).
action_label(comply_with_regulations, 'Comply with regulations').
action_type(comply_with_security_policy).
action_label(comply_with_security_policy, 'Comply with security policy').
action_type(conduct_ethically_and_responsibly).
action_label(conduct_ethically_and_responsibly, 'Act ethically and responsibly').
action_type(continue_contract_execution_after_sanction).
action_label(continue_contract_execution_after_sanction, 'Continue execution after sanction').
action_type(corporate_restructuring).
action_label(corporate_restructuring, 'Permitted corporate restructuring').
action_type(deduct_credits).
action_label(deduct_credits, 'Deduct credits').
action_type(deduct_payments).
action_label(deduct_payments, 'Deduct payments').
action_type(deduct_values).
action_label(deduct_values, 'Deduct values').
action_type(demand_service_execution_according_to_standards).
action_label(demand_service_execution_according_to_standards, 'Demand service execution according to standards').
action_type(demand_strict_compliance_after_omission).
action_label(demand_strict_compliance_after_omission, 'No right to demand after omission').
action_type(designate_contract_inspector).
action_label(designate_contract_inspector, 'Designate contract inspector').
action_type(designate_contract_manager).
action_label(designate_contract_manager, 'Designate contract manager').
action_type(designate_contract_manager_substitute).
action_label(designate_contract_manager_substitute, 'Designate contract manager substitute').
action_type(designate_receiving_committee).
action_label(designate_receiving_committee, 'Designate receiving committee').
action_type(designate_representative).
action_label(designate_representative, 'Designate representative').
action_type(discard_information).
action_label(discard_information, 'Discard information').
action_type(effect_object_receipt).
action_label(effect_object_receipt, 'Effect object receipt').
action_type(effect_payment).
action_label(effect_payment, 'Effect payment').
action_type(eliminate_personal_data).
action_label(eliminate_personal_data, 'Eliminate personal data').
action_type(ensure_safety_compliance).
action_label(ensure_safety_compliance, 'Ensure safety compliance').
action_type(exclude_from_simples_nacional).
action_label(exclude_from_simples_nacional, 'Exclude from Simples Nacional').
action_type(execute_contract).
action_label(execute_contract, 'Duty to execute contract').
action_type(execute_contract_according_to_specifications).
action_label(execute_contract_according_to_specifications, 'Execute contract per specifications').
action_type(execute_contract_object).
action_label(execute_contract_object, 'Execute contract object').
action_type(execute_services_according_to_standards).
action_label(execute_services_according_to_standards, 'Execute services according to standards').
action_type(exercise_contract_rights).
action_label(exercise_contract_rights, 'Right to exercise rights').
action_type(exercise_rights_any_time).
action_label(exercise_rights_any_time, 'Permission to exercise rights').
action_type(expect_execution_according_to_specifications).
action_label(expect_execution_according_to_specifications, 'Expect contract execution per specifications').
action_type(extend_guarantee_presentation_deadline).
action_label(extend_guarantee_presentation_deadline, 'Extend guarantee deadline').
action_type(formalize_contract_alteration).
action_label(formalize_contract_alteration, 'Formalize contract alteration').
action_type(formulate_revision_request).
action_label(formulate_revision_request, 'Formulate revision request').
action_type(guarantee_license_authenticity).
action_label(guarantee_license_authenticity, 'Guarantee license authenticity').
action_type(guarantee_no_infringement).
action_label(guarantee_no_infringement, 'Guarantee no infringement').
action_type(indicate_and_update_contact_info).
action_label(indicate_and_update_contact_info, 'Indicate/update contact info').
action_type(inform_bndes_conflict_of_interest).
action_label(inform_bndes_conflict_of_interest, 'Inform BNDES of conflict of interest').
action_type(inform_bndes_data_requests).
action_label(inform_bndes_data_requests, 'Inform BNDES of data requests').
action_type(inform_bndes_of_confidentiality_breaches).
action_label(inform_bndes_of_confidentiality_breaches, 'Inform BNDES of confidentiality breaches').
action_type(inform_toll_free_number).
action_label(inform_toll_free_number, 'Inform toll-free number').
action_type(initiate_price_revision).
action_label(initiate_price_revision, 'Initiate price revision').
action_type(issue_credit_title).
action_label(issue_credit_title, 'No right to issue credit title').
action_type(limit_access_to_information).
action_label(limit_access_to_information, 'Limit access to information').
action_type(maintain_confidentiality).
action_label(maintain_confidentiality, 'Maintain confidentiality').
action_type(maintain_confidentiality_of_information).
action_label(maintain_confidentiality_of_information, 'Maintain confidentiality').
action_type(maintain_contractual_terms).
action_label(maintain_contractual_terms, 'Duty to maintain original terms').
action_type(maintain_data_treatment_records).
action_label(maintain_data_treatment_records, 'Maintain data treatment records').
action_type(maintain_habilitation_conditions).
action_label(maintain_habilitation_conditions, 'Maintain qualification conditions').
action_type(maintain_integrity_public_private).
action_label(maintain_integrity_public_private, 'Maintain integrity in public-private relations').
action_type(make_payments_to_contracted).
action_label(make_payments_to_contracted, 'Make payments').
action_type(negotiate_price_reduction).
action_label(negotiate_price_reduction, 'Negotiate price reduction').
action_type(negotiate_prices_if_readjustment_too_high).
action_label(negotiate_prices_if_readjustment_too_high, 'Negotiate prices if readjustment too high').
action_type(not_access_confidential_information_without_authorization).
action_label(not_access_confidential_information_without_authorization, 'Do not access confidential information without authorization').
action_type(not_allocate_relatives_of_bndes_employees).
action_label(not_allocate_relatives_of_bndes_employees, 'Do not allocate relatives of BNDES employees').
action_type(not_offer_undue_advantage).
action_label(not_offer_undue_advantage, 'Do not offer undue advantage').
action_type(not_right_to_request_additives).
action_label(not_right_to_request_additives, 'No right to request additives').
action_type(notify_bndes_investigation).
action_label(notify_bndes_investigation, 'Notify BNDES of investigation').
action_type(notify_guarantor).
action_label(notify_guarantor, 'Notify guarantor').
action_type(notify_of_breach_and_provide_opportunity_to_cure).
action_label(notify_of_breach_and_provide_opportunity_to_cure, 'Notify of breach and provide opportunity to cure').
action_type(obey_instructions).
action_label(obey_instructions, 'Obey instructions').
action_type(observe_policies_and_code_of_ethics).
action_label(observe_policies_and_code_of_ethics, 'Observe policies and code of ethics').
action_type(observe_terms_of_confidentiality).
action_label(observe_terms_of_confidentiality, 'Observe terms of confidentiality').
action_type(obtain_bndes_approval).
action_label(obtain_bndes_approval, 'Subject to BNDES approval').
action_type(obtain_consent_data_holders).
action_label(obtain_consent_data_holders, 'Obtain consent from data holders').
action_type(obtain_guarantor_agreement).
action_label(obtain_guarantor_agreement, 'Obtain guarantor agreement').
action_type(obtain_new_guarantee).
action_label(obtain_new_guarantee, 'Obtain new guarantee').
action_type(omit_formalization_of_contract_alteration).
action_label(omit_formalization_of_contract_alteration, 'Omit formalization').
action_type(omit_late_iss_collection).
action_label(omit_late_iss_collection, 'Omit late ISS collection').
action_type(omit_litigation_elsewhere).
action_label(omit_litigation_elsewhere, 'Omit litigation elsewhere').
action_type(omit_requesting_additives).
action_label(omit_requesting_additives, 'Omit requesting additives').
action_type(partially_execute_and_receive).
action_label(partially_execute_and_receive, 'Partially execute and receive').
action_type(pay_charges_and_taxes).
action_label(pay_charges_and_taxes, 'Pay taxes').
action_type(pay_contracted_party).
action_label(pay_contracted_party, 'Pay contracted party').
action_type(permit_central_bank_access).
action_label(permit_central_bank_access, 'Permit central bank access').
action_type(permit_inspections).
action_label(permit_inspections, 'Permit inspections').
action_type(present_confidentiality_agreements).
action_label(present_confidentiality_agreements, 'Present confidentiality agreements').
action_type(present_dif).
action_label(present_dif, 'Present DIF').
action_type(present_fiscal_document).
action_label(present_fiscal_document, 'Present fiscal document').
action_type(present_information_price_reduction).
action_label(present_information_price_reduction, 'Present information for price reduction').
action_type(present_manifestation_on_extension).
action_label(present_manifestation_on_extension, 'Present manifestation on extension').
action_type(present_proof_of_cost_variation).
action_label(present_proof_of_cost_variation, 'Present proof of cost variation').
action_type(prevent_favoritism_bndes_employees).
action_label(prevent_favoritism_bndes_employees, 'Prevent favoritism to BNDES employees').
action_type(protect_freedom_privacy_rights).
action_label(protect_freedom_privacy_rights, 'Protect freedom and privacy rights').
action_type(prove_absence_of_sanctioning_decision).
action_label(prove_absence_of_sanctioning_decision, 'Prove no administrative sanction').
action_type(provide_access_to_ethics_code).
action_label(provide_access_to_ethics_code, 'Provide access to ethics code').
action_type(provide_additional_guarantee).
action_label(provide_additional_guarantee, 'Provide additional guarantee').
action_type(provide_cadastro_municipal).
action_label(provide_cadastro_municipal, 'Provide cadastro municipal').
action_type(provide_channel_for_data_access).
action_label(provide_channel_for_data_access, 'Provide channel for data access').
action_type(provide_clarifications).
action_label(provide_clarifications, 'Provide clarifications').
action_type(provide_contractual_guarantee).
action_label(provide_contractual_guarantee, 'Provide contractual guarantee').
action_type(provide_necessary_info).
action_label(provide_necessary_info, 'Provide necessary information').
action_type(provide_supporting_documents).
action_label(provide_supporting_documents, 'Provide supporting documents').
action_type(provide_technical_support).
action_label(provide_technical_support, 'Provide technical support').
action_type(provide_written_notice_before_termination).
action_label(provide_written_notice_before_termination, 'Provide written notice before termination').
action_type(provide_written_notice_of_termination).
action_label(provide_written_notice_of_termination, 'Provide written notice of termination').
action_type(receive_credits).
action_label(receive_credits, 'Right to receive credits').
action_type(receive_indemnification).
action_label(receive_indemnification, 'Receive indemnification').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_payments_from_bndes).
action_label(receive_payments_from_bndes, 'Receive payments').
action_type(receive_technical_support).
action_label(receive_technical_support, 'Receive technical support').
action_type(reduce_payments).
action_label(reduce_payments, 'Reduce payments').
action_type(reject_fiscal_document).
action_label(reject_fiscal_document, 'Reject fiscal document').
action_type(repair_damages).
action_label(repair_damages, 'Repair damages').
action_type(repair_object).
action_label(repair_object, 'Repair object').
action_type(request_additional_data).
action_label(request_additional_data, 'Request additional data').
action_type(request_price_readjustment).
action_label(request_price_readjustment, 'Request price readjustment').
action_type(request_price_readjustment_revision_before_end).
action_label(request_price_readjustment_revision_before_end, 'Request price adjustments before contract end').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(request_proof_of_absence_of_sanctioning_decision).
action_label(request_proof_of_absence_of_sanctioning_decision, 'Request proof').
action_type(request_reconsideration_or_appeal).
action_label(request_reconsideration_or_appeal, 'Request reconsideration/appeal').
action_type(respect_economic_financial_balance_clause).
action_label(respect_economic_financial_balance_clause, 'Respect economic equilibrium clause').
action_type(respond_for_employees_expenses).
action_label(respond_for_employees_expenses, 'Respond for employee expenses').
action_type(restrict_information_access).
action_label(restrict_information_access, 'Restrict info access').
action_type(retroactive_payment_after_deadline).
action_label(retroactive_payment_after_deadline, 'Retroactive payment after deadline').
action_type(return_bndes_property).
action_label(return_bndes_property, 'Return BNDES property').
action_type(return_resources).
action_label(return_resources, 'Return resources').
action_type(right_of_recourse).
action_label(right_of_recourse, 'Right of recourse').
action_type(subcontract_work).
action_label(subcontract_work, 'No right to subcontract').
action_type(subject_to_penalties_for_refusal).
action_label(subject_to_penalties_for_refusal, 'Subject to penalties for refusal').
action_type(subjected_to_penalties).
action_label(subjected_to_penalties, 'Subject to penalties').
action_type(sue_elsewhere).
action_label(sue_elsewhere, 'No right to sue elsewhere').
action_type(suspend_contract_execution).
action_label(suspend_contract_execution, 'Suspend execution').
action_type(suspend_readjustment_revision_request_analysis).
action_label(suspend_readjustment_revision_request_analysis, 'Suspend readjustment revision analysis').
action_type(terminate_contract).
action_label(terminate_contract, 'Terminate contract').
action_type(terminate_contract_after_suspension).
action_label(terminate_contract_after_suspension, 'Terminate contract after suspension').
action_type(terminate_contract_consensually).
action_label(terminate_contract_consensually, 'Terminate contract consensually').
action_type(terminate_contract_due_to_bankruptcy).
action_label(terminate_contract_due_to_bankruptcy, 'Terminate contract due to bankruptcy').
action_type(terminate_contract_due_to_delay).
action_label(terminate_contract_due_to_delay, 'Terminate contract due to delay').
action_type(terminate_contract_due_to_dissolution).
action_label(terminate_contract_due_to_dissolution, 'Terminate contract due to dissolution').
action_type(terminate_contract_due_to_force_majeure).
action_label(terminate_contract_due_to_force_majeure, 'Terminate contract due to force majeure').
action_type(terminate_contract_due_to_loss_of_qualification).
action_label(terminate_contract_due_to_loss_of_qualification, 'Terminate contract due to loss of qualification').
action_type(terminate_contract_due_to_union_sanction).
action_label(terminate_contract_due_to_union_sanction, 'Terminate contract due to union sanction').
action_type(terminate_contract_for_breach).
action_label(terminate_contract_for_breach, 'Terminate contract for breach').
action_type(terminate_contract_if_readjustment_negotiation_fails).
action_label(terminate_contract_if_readjustment_negotiation_fails, 'Terminate contract if readjustment negotiation fails').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_0218_2023).
contract_metadata(contrato_ocs_0218_2023, numero_ocs, '0218/2023').
contract_metadata(contrato_ocs_0218_2023, numero_sap, '4400005592').
contract_metadata(contrato_ocs_0218_2023, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇOS').
contract_metadata(contrato_ocs_0218_2023, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'LOTUS ICT EMPREENDIMENTOS S.A.']).
contract_metadata(contrato_ocs_0218_2023, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_0218_2023, contratado, 'LOTUS ICT EMPREENDIMENTOS S.A.').
contract_metadata(contrato_ocs_0218_2023, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_0218_2023, cnpj_contratado, '31.799.537/0001-97').
contract_metadata(contrato_ocs_0218_2023, procedimento_licitatorio, 'Pregão Eletrônico nº 009/2023 - BNDES').
contract_metadata(contrato_ocs_0218_2023, data_autorizacao, '10/07/2023').
contract_metadata(contrato_ocs_0218_2023, ip_ati_degat, '01/2023').
contract_metadata(contrato_ocs_0218_2023, data_ip_ati_degat, '06/07/2023').
contract_metadata(contrato_ocs_0218_2023, rubrica_orcamentaria, '3101700021').
contract_metadata(contrato_ocs_0218_2023, centro_custo, 'BN00004000').
contract_metadata(contrato_ocs_0218_2023, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_0218_2023, regulamento, 'Regulamento Licitações e Contratos do Sistema BNDES').
contract_clause(contrato_ocs_0218_2023, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a prestação continuada de serviços de suporte técnico e de manutenção evolutiva para a suíte de aplicativos BMC Remedy, conforme especificações constantes do Termo de Referência (Anexo I do Edital do Pregão Eletrônico nº 009/2023 - BNDES) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_0218_2023, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração de 24 (vinte e quatro) meses, contados a partir de 21 de outubro de 2023 ou da data de assinatura do contrato, o que ocorrer por último, podendo ser prorrogado, mediante aditivo, até o limite total de 60 (sessenta) meses.  Parágrafo Primeiro O CONTRATADO deverá, no prazo de até 5 (cinco) dias úteis, contados da notificação do Gestor do Contrato, apresentar, por intermédio do seu Representante Legal, sua manifestação sobre a prorrogação do Contrato.  Parágrafo Segundo Independente da notificação do parágrafo anterior, o CONTRATADO deverá comunicar ao Gestor seu interesse quanto à prorrogação do contrato até 90 (noventa) dias antes do término de cada período de vigência contratual.  Parágrafo Terceiro A formalização da prorrogação será efetuada por meio de aditivo epistolar, dispensando-se a assinatura do CONTRATADO  Parágrafo Quarto Caso o CONTRATADO se recuse a celebrar aditivo contratual de prorrogação, tendo antes manifestado sua intenção de prorrogar o Contrato ou deixado de manifestar seu propósito de não prorrogar, nos termos do Parágrafo Primeiro desta Cláusula, ficará sujeito às penalidades previstas na Cláusula de Penalidades deste Contrato.').
contract_clause(contrato_ocs_0218_2023, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do objeto contratado respeitará as especificações constantes do Termo de Referência (Anexo I deste Contrato) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_0218_2023, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO', 'Os serviços contratados deverão ser executados de acordo com os padrões de qualidade, disponibilidade e desempenho estipulados pelo BNDES, observados os níveis de serviço descritos no Anexo I (Termo de Referência) deste Contrato.  Parágrafo Único O descumprimento dos níveis de serviço acarretará a aplicação dos índices de redução do preço previstos no Anexo I (Termo de Referência) deste Contrato, sem prejuízo da aplicação das penalidades previstas neste Contrato, quando cabíveis.').
contract_clause(contrato_ocs_0218_2023, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através do Gestor, com o apoio dos membros da Equipe Técnica do BNDES, mencionados na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Anexo I (Termo de Referência) deste Contrato.').
contract_clause(contrato_ocs_0218_2023, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará ao CONTRATADO, pela execução do objeto contratado, o valor de até R$ $ 1.499.898,09 (um milhão e quatrocentos e noventa e nove mil e oitocentos e noventa e oito reais e nove centavos), conforme proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento.  Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.  Parágrafo Segundo Na hipótese de o objeto ser, a critério do BNDES, parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.  Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização ao CONTRATADO.   Parágrafo Quarto O CONTRATADO deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua proposta, devendo complementá-los, caso os quantitativos previstos inicialmente em sua proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato.').
contract_clause(contrato_ocs_0218_2023, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, mensalmente para os serviços de suporte e por demanda para os serviços de manutenção evolutiva, por meio de crédito em conta bancária, em até 10 (dez) dias úteis, a contar da data de apresentação do documento fiscal ou equivalente legal (prioritariamente nota fiscal, e nos casos de dispensa da nota fiscal: fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pelo CONTRATADO, observado o disposto no Anexo I (Termo de Referência) deste Instrumento.  Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte da prestação do serviço.  Parágrafo Segundo A apresentação do documento de cobrança fora do prazo previsto nesta cláusula poderá implicar em sua rejeição e no direito do BNDES se ressarcir, preferencialmente, mediante desconto do valor a ser pago ao CONTRATADO, por qualquer penalidade tributária incidente pelo atraso.  Parágrafo Terceiro O primeiro documento fiscal ou equivalente legal terá como objeto de cobrança o período compreendido entre o dia de início da prestação dos serviços e o último dia desse mês, e os documentos fiscais ou equivalentes legais subsequentes terão como referência o período compreendido entre o primeiro e o último dia de cada mês. O último documento fiscal ou equivalente legal, por seu turno, referir-se-á ao período compreendido entre o primeiro dia do último mês da prestação dos serviços e o último dia de serviço prestado. Em todos os casos, o documento fiscal ou equivalente legal só poderá ser emitido e apresentado ao BNDES após a efetiva prestação do serviço, respeitado o disposto no Parágrafo anterior.  Parágrafo Quarto Para toda efetivação de pagamento, o Contratado deverá encaminhar o documento fiscal ou equivalente em meio digital para caixa postal eletrônica ou protocolar em sistema eletrônico próprio do BNDES, considerando as orientações do Contratante vigentes na ocasião do pagamento. No caso de emissão de documento fiscal exclusivamente em meio físico o mesmo deverá ser encaminhado ao protocolo do BNDES para devido registro de recebimento.  Parágrafo Quinto O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato; IV. número da Folha de Registro de Serviços (FRS), a ser informado pelo Gestor do Contrato; V. descrição detalhada do objeto executado e dos respectivos valores; VI. período de referência da execução do objeto; VII. nome e número do CNPJ do CONTRATADO, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VIII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; IX. nome e número do banco e da agência, bem como o número da conta corrente do CONTRATADO, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; X. tomador do serviço: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; XI. CNPJ do tomador do serviço: 33.657.248/0001-89; XII. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso;  XIII. código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento - DIF;  XIV. número de inscrição do contribuinte individual válido junto ao INSS (NIT ou PIS/PASEP); e XV. destaque das retenções tributárias aplicáveis, conforme estabelecido na DIF.  Parágrafo Sexto Os pagamentos a serem efetuados em favor do CONTRATADO estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pelo CONTRATADO. Em casos de dispensa ou benefício fiscal que implique em redução ou eliminação da retenção de tributos, o CONTRATADO fornecerá todos os documentos comprobatórios.  Parágrafo Sétimo Caso o CONTRATADO emita documento fiscal ou equivalente legal autorizado por Município diferente daquele onde se localiza o estabelecimento do BNDES tomador do serviço e destinatário da cobrança, deverá providenciar o cadastro junto à Secretaria Municipal de Fazenda ou órgão equivalente do Município do estabelecimento tomador, salvo quando se aplicar uma das exceções constantes dos incisos do artigo 3º da Lei Complementar Federal nº 116/03. A inexistência desse cadastro ou o cadastro em item diverso do faturado não constitui impeditivo ao processo de pagamento, mas um ônus a ser suportado pelo CONTRATADO, uma vez que o BNDES está obrigado a reter na fonte a quantia equivalente ao ISS dos serviços faturados, conforme legislação aplicável.  Parágrafo Oitavo O documento fiscal ou equivalente legal emitido pelo CONTRATADO deverá estar em conformidade com a legislação do Município onde o CONTRATADO esteja estabelecida, cuja regularidade fiscal foi avaliada na etapa de habilitação, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos, sob pena de devolução do documento e interrupção do prazo para pagamento.   Parágrafo Nono Ao documento fiscal ou equivalente legal deverão ser anexados: I. certidões de regularidade fiscal exigidas na fase de habilitação; II. comprovante de que o CONTRATADO é optante do Simples Nacional, se for o caso; III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; e IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado;  Parágrafo Décimo Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal ao CONTRATADO ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.   Parágrafo Décimo Primeiro Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pelo CONTRATADO.  Parágrafo Décimo Segundo Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível ao CONTRATADO, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.   Parágrafo Décimo Terceiro Fica assegurado ao BNDES o direito de deduzir do pagamento devido ao CONTRATADO, por força deste Contrato ou de outro contrato mantido com o BNDES, o valor correspondente aos pagamentos efetuados a maior ou em duplicidade.').
contract_clause(contrato_ocs_0218_2023, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO', 'O BNDES e o CONTRATADO têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pelo CONTRATADO a cada período de 12 (doze) meses, sendo o primeiro contado do dia 27/07/2023, data de apresentação da proposta (Anexo II deste Contrato), e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do Índice de Custo de Tecnologia da Informação - ICTI, divulgado pelo Instituto de Pesquisa Econômica Aplicada – IPEA, ou outro índice que vier a substituí-lo, sobre o preço referido na Cláusula de Preço deste Instrumento.  Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado. Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar o CONTRATADO para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo ao CONTRATADO apresentar as informações solicitadas pelo BNDES.   Parágrafo Quarto O CONTRATADO deverá solicitar o reajuste e/ou a revisão de preços até a prorrogação ou o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias da prorrogação ou do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a assinatura do aditivo de prorrogação torne superveniente a ocorrência do fato gerador do reajuste, ou a divulgação do índice de reajuste ocorra após a prorrogação ou o encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso o CONTRATADO não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, não fará jus aos efeitos retroativos ou, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.  Parágrafo Quinto Se o processo de reajuste e/ou revisão de preços não for concluído até o vencimento do Contrato, e este for prorrogado, sua continuidade após o reequilíbrio econômico-financeiro ficará condicionada à manutenção da proposta do CONTRATADO como a condição mais vantajosa para o BNDES, podendo este: I. realizar negociação de preços junto ao CONTRATADO, de forma a viabilizar a continuidade do ajuste, quando os novos valores fixados após o reajuste e/ou a revisão de preços estiverem acima do patamar apurado no mercado; ou  II. rescindir o Contrato, mediante aviso prévio ao CONTRATADO, com antecedência de 30 (trinta) dias, quando resultar infrutífera a negociação indicada no inciso anterior.  Parágrafo Sexto Na ocorrência da hipótese prevista no inciso II do Parágrafo anterior, o CONTRATADO fará jus à integralidade dos valores apurados no processo de reajuste e/ou revisão de preços até o término do Contrato, não podendo, todavia, reclamar qualquer indenização em razão da rescisão do mesmo.').
contract_clause(contrato_ocs_0218_2023, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS', 'O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.   Parágrafo Primeiro O reajuste de preço aludido na Matriz de Riscos deve respeitar o disposto na
contract_clause(contrato_ocs_0218_2023, clausula_decima_garantia_contratual, 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL', 'O CONTRATADO prestará, no prazo de até 10 (dez) dias úteis, contados da convocação, garantia contratual, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para sua aceitação estipuladas nos incisos abaixo, no valor de R$ 74.994,90 (setenta e quatro mil e novecentos e noventa e quatro reais e noventa centavos), que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas quando da referida convocação; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a) O Instrumento de Apólice de Seguro deve prever expressamente: a.1) responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas ao CONTRATADO; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. III. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a) O Instrumento de Fiança deve prever expressamente: a.1) renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.  Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pelo CONTRATADO durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.  Parágrafo Segundo Havendo majoração do preço contratado, decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, fica dispensada a atualização da garantia, salvo se o valor da atualização for igual ou superior ao patamar referenciado no inciso II do artigo 91 do Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Terceiro Nos demais casos que demandem a complementação ou renovação da garantia, tais como alteração do objeto (aditivo quantitativo ou qualitativo), prorrogação contratual, dentre outros, o CONTRATADO deverá providenciá-la no prazo estipulado pelo BNDES.    Parágrafo Quarto Sempre que o contrato for garantido por fiança bancária ou seguro garantia, o CONTRATADO deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe ao CONTRATADO obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.  Parágrafo Quinto A garantia contratual deverá cobrir: I. todas as obrigações decorrentes do objeto contratual, assim como eventuais danos decorrentes de seu descumprimento; II. todas as obrigações relacionadas ao objeto principal, ainda que decorrentes de sua manutenção e/ou refazimento, bem como das medidas necessárias à prevenção ordinária de sinistros, prejuízos e danos em geral; III. prejuízos decorrentes de atos de corrupção praticados sem participação dolosa do BNDES ou de seus representantes; IV. prejuízos diretos causados ao BNDES decorrentes de culpa ou dolo durante a execução do Contrato; V. multas moratórias e/ou punitivas aplicadas pelo BNDES ao CONTRATADO;  VI. obrigações trabalhistas e previdenciárias de qualquer natureza, não adimplidas pelo CONTRATADO, quando o objeto contratual demandar cessão de mão de obra com dedicação exclusiva.  Parágrafo Sexto Em caso de prorrogação da vigência ou alteração do objeto contratual, o CONTRATADO deverá notificar a entidade fiadora/seguradora, conforme o caso, no prazo de até 10 (dez) dias úteis, contados da formalização do respectivo Instrumento Contratual.  Parágrafo Sétimo Por se tratar de garantia contratual prestada em benefício de uma Estatal, caso os documentos de caução, fiança ou seguro façam referência à Lei nº 8.666/1993 e/ou à Lei nº 14.133/2021, aplicam-se as disposições respectivas da Lei nº 13.303/2016, no que couber.').
contract_clause(contrato_ocs_0218_2023, clausula_decima_primeira_obrigações_contratado, 'CLÁUSULA DÉCIMA PRIMEIRA – OBRIGAÇÕES DO CONTRATADO', 'Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação e a ausência de impedimentos exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. assumir a responsabilidade integral por quaisquer ônus que venham a ser impostos ao BNDES em virtude de documento fiscal que seja emitido em desacordo com a legislação aplicável; VII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VIII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; IX. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; X. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; XI. apresentar, em até 10 (dez) dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; XII. garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, podendo o CONTRATADO ser instado a intervir no processo;  XIII.  responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos profissionais alocados na execução dos serviços, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES; XIV. devolver recursos disponibilizados pelo BNDES, revogar perfis de acesso de seus profissionais, eliminar suas caixas postais e adotar demais providências aplicáveis ao término da vigência deste Contrato; XV. cumprir as disposições regulamentares pertinentes aos serviços a serem prestados, ficando ainda responsável, além de outras obrigações estipuladas no Contrato e nestas Especificações Técnicas; XVI. responder, em relação aos seus empregados, por todas as despesas decorrentes da execução dos serviços, tais como: salários, seguros de acidente, taxas, impostos, contribuições, indenizações, vale-refeição, vale-transporte e outras que porventura venham a ser criadas e exigidas pelo Poder Público; XVII. assumir inteira responsabilidade técnica e administrativa em relação ao objeto contratado, não podendo, sob qualquer hipótese, transferir a outras empresas a responsabilidade por problemas na prestação dos serviços; XVIII. atender prontamente quaisquer exigências do representante da Administração, no que diz respeito às necessidades do BNDES; XIX. prestar todos os esclarecimentos que lhe forem solicitados pelo BNDES; XX. manter sigilo relativamente ao objeto contratado, bem como sobre dados, documentos, especificações técnicas ou comerciais, não tornadas públicas pelo BNDES, de que venha a ter conhecimento em virtude da contratação, bem como a respeito da execução e resultados obtidos na prestação de serviços, inclusive após o término do prazo de vigência do Contrato, sendo vedada a divulgação dos referidos resultados a terceiros em geral, e em especial a quaisquer meios de comunicação públicos e/ou privados; XXI. garantir a autenticidade das licenças adquiridas sabendo que estará exposta a todas as sanções cíveis e criminais decorrentes dos atos de violação de direitos autorais e pirataria de software. XXII. indicar seus dados de endereço, telefone, fax e e-mail, mantendo-os atualizados perante o BNDES durante toda a vigência do(s) Contrato(s). XXIII. informar, em até 10 (dez) dias úteis após a convocação do BNDES, o número de telefone com tarifação reversa (tipo 0800) ou local do Rio de Janeiro (DDD 21) para abertura de chamados referentes ao suporte técnico. XXIV. descartar, ao final da vigência do Contrato, de forma definitiva, ou seja, de forma a impedir a sua recuperação total ou parcial posteriormente, toda informação do BNDES gerada, mantida, recebida, manipulada ou produzida durante a execução do Contrato que a contratada esteja custodiando. XXV. permitir acesso às informações do BNDES somente aos profissionais expressamente designados para a execução dos serviços contratados, não sendo permitido, portanto, o acesso de pessoas externas à empresa Contratada ou mesmo de profissionais da Contratada não designados para a prestação do serviço contratado ou que ainda não tenham assinado o devido Termo de Confidencialidade. XXVI. cumprir e obedecer às diretrizes da Política Corporativa de Segurança da Informação estabelecidas pelo BNDES. XXVII. permitir ao Banco Central do Brasil acesso a termos firmados, documentos e informações atinentes aos serviços prestados, bem como às suas dependências, nos termos do § 1º do artigo 33 da Resolução CMN nº 4.557/2017.');
contract_clause(contrato_ocs_0218_2023, clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, 'CLÁUSULA DÉCIMA SEGUNDA – CONDUTA ÉTICA DO CONTRATADO E DO BNDES', 'O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar a Política para Transações com Partes Relacionadas e o Código de Ética do Sistema BNDES vigentes ao tempo da contratação, bem como a Política Corporativa de Integridade do Sistema BNDES, assegurando-se de que seus representantes, administradores, todos os profissionais envolvidos na execução do objeto e eventuais subcontratados pautem seu comportamento e sua atuação pelos princípios neles constantes;  V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição;  VI. informar imediatamente ao BNDES a ocorrência de potencial situação de conflito de interesses, comunicando na mesma oportunidade as medidas que serão adotadas para o tratamento da questão; e VII. notificar imediatamente o BNDES sobre qualquer investigação ou procedimento iniciado por autoridade governamental relacionado à violação de Leis Anticorrupção (nacional ou estrangeira) e/ou de obrigações da empresa, de seus administradores, diretores, prepostos, empregados, representantes ou terceiros a seu serviço, incluindo subcontratados, referentes a este Contrato.  Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política Corporativa de Integridade do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).');
contract_clause(contrato_ocs_0218_2023, clausula_decima_terceira_sigilo_informacoes, 'CLÁUSULA DÉCIMA TERCEIRA – SIGILO DAS INFORMAÇÕES', 'Cabe ao CONTRATADO cumprir as seguintes regras de sigilo e assegurar a aceitação e adesão às mesmas por profissionais que integrem ou venham a integrar a sua equipe na prestação do objeto deste Contrato, as quais perdurarão, inclusive, após a cessação do vínculo contratual e da prestação dos serviços: I. cumprir as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES, necessárias para assegurar a integridade e o sigilo das informações;  II. não acessar informações sigilosas do BNDES, salvo quando previamente autorizado por escrito; III. sempre que tiver acesso às informações mencionadas no inciso anterior: a) manter sigilo dessas informações, não podendo copiá-las, reproduzi-las, retê-las ou praticar qualquer outra forma de uso que não seja imprescindível para a adequada prestação do objeto deste Contrato; b) limitar o acesso às informações aos profissionais envolvidos na prestação dos serviços objeto deste Contrato, os quais deverão estar cientes da natureza sigilosa das informações e das obrigações e responsabilidades decorrentes do uso dessas informações; e c) informar imediatamente ao BNDES qualquer violação das regras de sigilo ora estabelecidas que tenha ocorrido por sua ação ou omissão, independentemente da existência de dolo, bem como dos profissionais envolvidos, adotando todas as orientações do BNDES para remediar a violação; IV. entregar ao BNDES, ao término da vigência deste Contrato, todo e qualquer material de propriedade deste, inclusive notas pessoais envolvendo matéria sigilosa e registro de documentos de qualquer natureza que tenham sido criados, usados ou mantidos sob seu controle ou posse, assumindo o compromisso de não utilizar qualquer informação sigilosa a que teve acesso no âmbito deste Contrato;  V. apresentar, antes do início da prestação dos serviços, Termos de Confidencialidade, conforme minuta constante do Anexo V (Minuta de Termo de Confidencialidade para Profissionais) deste Contrato, assinados pelos profissionais que acessarão informações sigilosas, devendo referida obrigação ser também cumprida por ocasião de substituição desses profissionais; e VI. observar o disposto no Termo de Confidencialidade assinado por seu Representante Legal constante do Anexo IV (Termo de Confidencialidade para Representante Legal) deste Contrato.').
contract_clause(contrato_ocs_0218_2023, clausula_decima_quarta_acesso_protecao_dados_pessoais, 'CLÁUSULA DÉCIMA QUARTA – ACESSO E PROTEÇÃO DE DADOS PESSOAIS', 'As partes assumem o compromisso de proteger os direitos fundamentais de liberdade e de privacidade, relativos ao tratamento de dados pessoais, nos meios físicos e digitais, devendo, para tanto, adotar medidas de boa governança sob o aspecto técnico, jurídico e administrativo, inclusive de segurança, e observar que:    I.Eventual tratamento de dados pessoais em razão do presente Contrato deverá ser realizado conforme os parâmetros previstos na legislação, especialmente na Lei n° 13.709/2018 – Lei Geral de Proteção de Dados Pessoais - LGPD, dentro de propósitos legítimos, específicos, explícitos e informados ao titular;   II.O tratamento será limitado às atividades necessárias ao atingimento das finalidades contratuais e, caso seja necessário, ao cumprimento de suas obrigações legais ou regulatórias, sejam de ordem principal ou acessória, observando-se que, em caso de necessidade de coleta de dados pessoais diretamente pelo CONTRATADO, esta será realizada mediante prévia aprovação do BNDES, responsabilizando-se o CONTRATADO por obter o consentimento dos titulares, salvo nos casos em que a legislação dispense tal medida;  III.O CONTRATADO deverá seguir as instruções recebidas do BNDES em relação ao tratamento de dados pessoais;  IV.No caso de tratamento de dados pessoais realizado pelo CONTRATADO para cumprimento de suas obrigações legais ou para atendimento de suas próprias finalidades, o BNDES não será considerado “Controlador de Dados Pessoais” e, sim, o CONTRATADO;  V.Os dados coletados somente poderão ser utilizados pelas partes, seus representantes, empregados e prestadores de serviços diretamente alocados na execução contratual, sendo que, em hipótese alguma, poderão ser compartilhados ou utilizados para outros fins, sem a prévia autorização do BNDES, ou caso haja alguma ordem judicial, observando-se as medidas legalmente previstas para tanto;  VI.O CONTRATADO deve manter a confidencialidade dos dados pessoais obtidos em razão do presente contrato, devendo adotar as medidas técnicas e administrativas adequadas e necessárias, visando assegurar a proteção dos dados, nos termos do artigo 46 da LGPD, de modo a garantir um nível apropriado de segurança e a prevenção e mitigação de eventuais riscos;  VII.Os dados deverão ser armazenados de maneira segura pelo CONTRATADO, que utilizará recursos de segurança da informação e tecnologia adequados, inclusive quanto a mecanismos de detecção e prevenção de ataques cibernéticos e incidentes de segurança da informação.  VIII.O CONTRATADO dará conhecimento formal para seus empregados e/ou prestadores de serviço acerca das disposições previstas nesta Cláusula e na Cláusula de Sigilo das Informações, responsabilizando-se por eventual uso indevido dos dados pessoais, bem como por quaisquer falhas nos sistemas por ela empregados para o tratamento dos dados.  IX.O BNDES possui direito de regresso em face do CONTRATADO em razão de eventuais danos causados por este em decorrência do descumprimento das responsabilidades e obrigações previstas no âmbito deste contrato e da Lei Geral de Proteção de Dados Pessoais;  X.O CONTRATADO deverá disponibilizar ao titular do dado um canal ou sistema em que seja garantida consulta facilitada e gratuita sobre a forma, a duração do tratamento e a integralidade de seus dados pessoais.  XI.O CONTRATADO deverá informar imediatamente ao BNDES todas as solicitações recebidas em razão do exercício dos direitos pelo titular dos dados relacionados a este Contrato, seguindo as orientações fixadas pelo BNDES e pela legislação em vigor para o adequado endereçamento das demandas.  XII.O CONTRATADO deverá manter registro de todas as operações de tratamento de dados pessoais que realizar no âmbito do Contrato disponibilizando, sempre que solicitado pelo BNDES, as informações necessárias à produção do Relatório de Impacto de Dados Pessoais, disposto no artigo 5º, XVII, da Lei Geral de Proteção de Dados Pessoais.  XIII.Qualquer incidente ao qual o CONTRATADO tiver dado causa e que implique em violação ou risco de violação ou vazamento de dados pessoais deverá ser prontamente comunicado ao BNDES, informando-se também todas as providências adotadas e os dados pessoais eventualmente afetados, cabendo ao CONTRATADO disponibilizar as informações e documentos solicitados e colaborar com qualquer investigação ou auditoria que venha a ser realizada.  XIV.Ao final da vigência do Contrato, o CONTRATADO deverá eliminar de sua base de informações todo e qualquer dado pessoal que tenha tido acesso em razão da execução do objeto contratado, salvo quando tenha que manter a informação para o cumprimento de obrigação legal.  Parágrafo Primeiro  As Partes reconhecem que, se durante a execução do Contrato armazenarem, coletarem, tratarem ou de qualquer outra forma processarem dados pessoais, no sentido dado pela legislação vigente aplicável, o BNDES será considerado “Controlador de Dados”, e o CONTRATADO “Operador” ou “Processador de Dados”, salvo nas situações expressas em contrário nesse Contrato. Contudo, caso o CONTRATADO descumpra as obrigações prevista na legislação de proteção de dados ou as instruções do BNDES, será equiparado a “Controlador de Dados”, inclusive para fins de sua responsabilização por eventuais danos causados.  Parágrafo Segundo Cada uma das Partes será controladora independente, para os fins desse CONTRATO, cabendo definir individualmente as bases legais apropriadas e diretrizes para as operações de tratamento, em relação aos seguintes dados pessoais: (i) que vierem a coletar diretamente junto aos respectivos titulares, desde que essa operação de tratamento se dê com base em suas próprias decisões; (ii) oriundos de suas próprias bases de dados; e (iii) relativos ao seu corpo de colaboradores, funcionários e/ou prepostos envolvidos para a regular execução deste Contrato.  Parágrafo Terceiro Caso o CONTRATADO disponibilize dados de terceiros, além das obrigações no caput desta Cláusula, deve se responsabilizar por eventuais danos que o BNDES venha a sofrer em decorrência de uso indevido de dados pessoais por parte do CONTRATADO, sempre que ficar comprovado que houve falha de segurança técnica e administrativa, descumprimento de regras previstas na legislação de proteção à privacidade e dados pessoais, e das orientações do BNDES, sem prejuízo das penalidades deste Contrato.  Parágrafo Quarto A assinatura deste Contrato importa na manifestação de inequívoco consentimento do titular, seja ele pessoa física direta ou indiretamente relacionada ao CONTRATADO, inclusive sócios, representantes legais, empregados, contratados e/ou terceirizados, quando for o caso, dos dados pessoais que tenham se tornados públicos como condição para participação na licitação e para contratação, para tratamento pelo BNDES, na forma da Lei nº 13.709/2018. Poderão ser solicitados pelo BNDES dados pessoais adicionais a fim de viabilizar o cumprimento de obrigação legal.  Parágrafo Quinto Os representantes legais signatários do presente autorizam a divulgação dos dados pessoais expressamente contidos nos documentos decorrentes do procedimento de licitação, tais como nome, CPF, e-mail, telefone e cargo, para fins de publicidade das contratações administrativas no site institucional do BNDES e em cumprimento à Lei nº 12.527/ 2011 (Lei de Acesso à Informação).  Parágrafo Sexto As partes comprometem-se a coletar o consentimento, quando necessário, conforme previsto na Lei nº 13.709/2018 (Lei Geral de Proteção de Dados Pessoais - LGPD), bem como informar aos titulares dos dados pessoais mencionados no presente instrumento, para as finalidades descritas no parágrafo acima.').
contract_clause(contrato_ocs_0218_2023, clausula_decima_quinta_obrigações_bndes, 'CLÁUSULA DÉCIMA QUINTA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos ao CONTRATADO, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, Fabio Dias Fagundez, que atualmente exerce a função de Gerente na ATI/DESIS4/GESAM, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução dos serviços, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. designar, como substituto do Gestor do Contrato, para atuar em sua eventual ausência, quem o estiver substituindo na função de gerente; IV. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita ao CONTRATADO; V. designar o Fiscal do Contrato que auxiliará o Gestor do Contrato no acompanhamento, na fiscalização e na avaliação da execução do objeto;  VI. designar a Comissão de Recebimento, a quem caberá o recebimento do objeto, em conjunto com o Gestor do Contrato;  VII. fornecer ao CONTRATADO, quando solicitado ao Gestor do Contrato, acesso ao Código de Ética do Sistema BNDES, da Política Corporativa de Integridade do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; VIII. colocar à disposição do CONTRATADO todas as informações necessárias à perfeita execução dos serviços objeto deste Contrato; e IX. comunicar ao CONTRATADO, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares do CONTRATADO, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_0218_2023, clausula_decima_sexta_equidade_genero_valorizacao_diversidade, 'CLÁUSULA DÉCIMA SEXTA – EQUIDADE DE GÊNERO E VALORIZAÇÃO DA DIVERSIDADE', 'O CONTRATADO deverá comprovar, sempre que solicitado pelo BNDES, a inexistência de decisão administrativa final sancionadora, exarada por autoridade ou órgão competente, em razão da prática de atos, pelo próprio CONTRATADO ou dirigentes, administradores ou sócios majoritários, que importem em discriminação de raça ou gênero, exploração irregular, ilegal ou criminosa do trabalho infantil ou prática relacionada ao trabalho em condições análogas à escravidão, e de sentença condenatória transitada em julgado, proferida em decorrência dos referidos atos, e, se for o caso, de outros que caracterizem assédio moral ou sexual e importem em crime contra o meio ambiente.  Parágrafo Primeiro Na hipótese de ter havido decisão administrativa e/ou sentença condenatória, nos termos referidos no caput desta Cláusula, a execução do objeto contratual poderá ser suspensa pelo BNDES até a comprovação do cumprimento da reparação imposta ou da reabilitação do CONTRATADO ou de seus dirigentes, conforme o caso.  Parágrafo Segundo A comprovação a que se refere o caput desta Cláusula será realizada por meio de declaração, sem prejuízo da verificação do sistema informativo interno do BNDES – Sistema de Gerenciamento do Cadastro de Entidades (N02), acerca da inexistência de sanção em face do CONTRATADO e/ou de seus dirigentes, administradores ou sócios majoritários que impeça a contratação.').
contract_clause(contrato_ocs_0218_2023, clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, 'CLÁUSULA DÉCIMA SÉTIMA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO', 'É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte do CONTRATADO, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro É admitida a sucessão contratual nas hipóteses em que o CONTRATADO realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É vedada a subcontratação para a execução do objeto deste Contrato.').
contract_clause(contrato_ocs_0218_2023, clausula_decima_oitava_penalidades, 'CLÁUSULA DÉCIMA OITAVA – PENALIDADES', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, o CONTRATADO ficará sujeito às seguintes penalidades: I. advertência; II. multa, de acordo com o Anexo I (Termo de Referência); e III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro As penalidades serão aplicadas observadas as normas do Regulamento de Licitações e Contratos do SISTEMA BNDES.     Parágrafo Segundo  Contra a decisão de aplicação de penalidade, o CONTRATADO poderá requerer a reconsideração para a decisão de advertência, ou interpor o recurso cabível para as demais penalidades, na forma e no prazo previstos no Regulamento de Licitações e Contratos do SISTEMA BNDES.  Parágrafo Terceiro  A imposição de penalidade prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto  A multa poderá ser aplicada juntamente com as demais penalidades.  Parágrafo Quinto  A multa aplicada ao CONTRATADO e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ele devidos, assim como da garantia prestada, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto  No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Sétimo A celebração de Termo de Ajustamento de Conduta prevista no Regulamento de Licitações e Contratos do Sistema BNDES não importa em renúncia às penalidades prevista neste Contrato e no Anexo I (Termo de Referência).  Parágrafo Oitavo A sanção prevista no inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.').
contract_clause(contrato_ocs_0218_2023, clausula_decima_nona_alteracoes_contratuais, 'CLÁUSULA DÉCIMA NONA – ALTERAÇÕES CONTRATUAIS', 'O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que:  I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.     Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento, os ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato e alterações de preços decorrentes decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, que poderão ser celebrados por meio epistolar.').
contract_clause(contrato_ocs_0218_2023, clausula_vigesima_extincao_contrato, 'CLÁUSULA VIGÉSIMA– EXTINÇÃO DO CONTRATO', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, e ainda: I. Consensualmente, formalizada em autorização escrita e fundamentada do BNDES, mediante aviso prévio por escrito, com antecedência mínima de 90 (noventa) dias ou de prazo menor a ser negociado pelas partes à época da rescisão; II. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; III. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; IV. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo;  V. quando for decretada a falência do CONTRATADO; VI. caso o CONTRATADO perca uma das condições de habilitação exigidas quando da contratação; VII. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VIII. caso o CONTRATADO seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  IX. em função da suspensão do direito de o CONTRATADO licitar ou contratar com o BNDES; X. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei nº 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual; XI. em razão da dissolução do CONTRATADO;  XII. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato, e de oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_0218_2023, clausula_vigesima_primeira_disposicoes_finais, 'CLÁUSULA VIGÉSIMA PRIMEIRA– DISPOSIÇÕES FINAIS', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram o presente Contrato: Anexo I - Termo de Referência do Pregão Eletrônico nº 009/2023- BNDES Anexo II - Proposta Anexo III - Matriz de Risco Anexo IV - Termo de Confidencialidade para Representante Legal Anexo V- Minuta de Termo de Confidencialidade para Profissionais   Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_0218_2023, clausula_vigesima_segunda_foro, 'CLÁUSULA VIGÉSIMA SEGUNDA– FORO', 'É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As partes consideram, para todos os efeitos, a data da última assinatura digital como a data de formalização jurídica deste instrumento.  As folhas deste contrato foram conferidas por Márcio Oliveira da Rocha, advogado do BNDES, por autorização do representante legal que o assina.     _______________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES    _______________________________________________________________ LOTUS ICT EMPREENDIMENTOS S.A.   Testemunhas:   _________________________________        ________________________________').

% ===== END =====
